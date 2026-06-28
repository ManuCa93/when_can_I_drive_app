import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';

import '../utils/notification_service.dart';
import '../providers/app_providers.dart';
import '../utils/bac_calculator.dart';

class BacHeaderWidget extends ConsumerStatefulWidget {
  const BacHeaderWidget({super.key});

  @override
  ConsumerState<BacHeaderWidget> createState() => _BacHeaderWidgetState();
}

class _BacHeaderWidgetState extends ConsumerState<BacHeaderWidget> {
  Timer? _timer;
  double _maxBacRed = 0.0;
  double _maxBacGreen = 0.0;
  String _lastDrinksKey = '';
  
  String _lastBacString = '';
  String _lastTargetTime = '';

  @override
  void initState() {
    super.initState();
    NotificationService.init();

    _timer = Timer.periodic(const Duration(seconds: 15), (_) {
      if (mounted) {
        setState(() {});
        _updateNotification();
      }
    });
  }

  void _updateNotification() {
    final loc = AppLocalizations.of(context);
    if (loc == null) return;

    final user = ref.read(userProvider);
    final drinks = ref.read(drinksProvider);
    final currentBac = BacCalculator.calculateCurrentBAC(drinks, user);

    if (currentBac > 0) {
      final isOverLimit = currentBac > user.legalLimit;
      final timerDuration = isOverLimit 
          ? BacCalculator.timeUntilLegalLimit(currentBac, user.legalLimit)
          : BacCalculator.timeUntilSober(currentBac);
      
      final targetDateTime = DateTime.now().add(timerDuration);
      final targetTimeText = DateFormat('HH:mm').format(targetDateTime);
      final currentBacString = currentBac.toStringAsFixed(2);

      if (_lastBacString != currentBacString || _lastTargetTime != targetTimeText) {
        _lastBacString = currentBacString;
        _lastTargetTime = targetTimeText;

        NotificationService.updateBacNotification(
          currentBac: currentBac,
          targetTime: targetTimeText,
          isOverLimit: isOverLimit,
          statusLabel: isOverLimit ? loc.underLimitAt : loc.soberAt, 
          channelName: loc.appTitle, 
        );
      }
    } else {
      if (_lastBacString != "0.00") {
        _lastBacString = "0.00";
        NotificationService.updateBacNotification(
          currentBac: 0,
          targetTime: "",
          isOverLimit: false,
          statusLabel: "", 
          channelName: loc.appTitle, 
        );
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(drinksProvider, (_, __) => _updateNotification());
    ref.listen(userProvider, (_, __) => _updateNotification());

    final loc = AppLocalizations.of(context)!;
    final user = ref.watch(userProvider);
    final drinks = ref.watch(drinksProvider);
    final theme = Theme.of(context);

    final currentBac = BacCalculator.calculateCurrentBAC(drinks, user);
    final isOverLimit = currentBac > user.legalLimit;

    final drinksKey = drinks.map((d) => '${d.id}-${d.volume}-${d.abv}').join('|');
    if (drinksKey != _lastDrinksKey) {
      _lastDrinksKey = drinksKey;
      _maxBacRed = currentBac;
      _maxBacGreen = currentBac;
    }

    double displayPercent = 0.0;
    Color circleColor = Colors.grey[200]!;
    String targetLabel = "";
    Duration timerDuration = Duration.zero;

    if (currentBac <= 0) {
      _maxBacRed = 0.0;
      _maxBacGreen = 0.0;
    } else if (isOverLimit) {
      circleColor = Colors.orange[600]!;
      targetLabel = loc.underLimitAt;
      timerDuration = BacCalculator.timeUntilLegalLimit(currentBac, user.legalLimit);
      
      if (_maxBacRed < currentBac) _maxBacRed = currentBac; 
      
      double range = _maxBacRed - user.legalLimit;
      displayPercent = range > 0 ? ((currentBac - user.legalLimit) / range).clamp(0.0, 1.0) : 1.0;
    } else {
      circleColor = Colors.lightGreen[400]!;
      targetLabel = loc.soberAt;
      timerDuration = BacCalculator.timeUntilSober(currentBac);
      
      if (_maxBacGreen < currentBac) _maxBacGreen = currentBac;
      
      displayPercent = _maxBacGreen > 0 ? (currentBac / _maxBacGreen).clamp(0.0, 1.0) : 1.0;
    }

    final targetDateTime = DateTime.now().add(timerDuration);
    final targetTimeText = DateFormat('HH:mm', Localizations.localeOf(context).languageCode).format(targetDateTime);

    return Column(
      children: [
        TweenAnimationBuilder<double>(
          key: ValueKey(drinksKey), 
          tween: Tween<double>(begin: 0.0, end: displayPercent),
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeOutCubic,
          builder: (context, animatedValue, child) {
            return CircularPercentIndicator(
              radius: 140.0,
              lineWidth: 18.0,
              animation: false, 
              percent: animatedValue, 
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: circleColor,
              backgroundColor: Colors.grey.withOpacity(0.2),
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(loc.currentBac, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                  Text(
                    "${currentBac.toStringAsFixed(2)} g/l",
                    style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
                  ),
                  const SizedBox(height: 8),
                  if (currentBac > 0) ...[
                    const Icon(Icons.timer_outlined, size: 20, color: Colors.grey),
                    Text(
                      "${timerDuration.inHours}h ${timerDuration.inMinutes.remainder(60)}m",
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text("$targetLabel $targetTimeText", style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
                  ] else
                    Text(loc.youAreSober, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.green)),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
