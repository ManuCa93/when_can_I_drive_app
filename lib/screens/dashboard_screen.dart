import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';

import '../utils/notification_service.dart';
import '../providers/app_providers.dart';
import '../utils/bac_calculator.dart';
import '../widgets/add_drink_bottom_sheet.dart';
import '../models/drink_log.dart';
import 'settings_screen.dart'; 

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  Timer? _timer;
  double _maxBacRed = 0.0;
  double _maxBacGreen = 0.0;
  
  // Variabile per ricalibrare l'animazione del cerchio quando aggiungi/rimuovi drink
  String _lastDrinksKey = '';
  bool _isWaterDrank = false;

  @override
  void initState() {
    super.initState();
    NotificationService.init();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {});
        
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

          NotificationService.updateBacNotification(
            currentBac: currentBac,
            targetTime: targetTimeText,
            isOverLimit: isOverLimit,
            statusLabel: isOverLimit ? loc.underLimitAt : loc.soberAt, 
            channelName: loc.appTitle, 
          );
        }
      }
    });
  }

  // Traduzione dinamica dei nomi salvati
  String _getTranslatedDrinkName(String name, AppLocalizations loc) {
    final n = name.toLowerCase();
    if (n == 'birra' || n == 'beer') return loc.beer;
    if (n == 'vino' || n == 'wine') return loc.wine;
    if (n == 'shot') return loc.shot;
    if (n == 'amaro' || n == 'bitter') return loc.amaro;
    if (n == 'cocktail') return loc.cocktail;
    return name; 
  }

  // Helper per icone dinamiche
  IconData _getDrinkIcon(String name) {
    final n = name.toLowerCase();
    if (n.contains('birra') || n.contains('beer')) return Icons.sports_bar_rounded;
    if (n.contains('vino') || n.contains('wine')) return Icons.wine_bar_rounded;
    if (n.contains('shot') || n.contains('amaro') || n.contains('bitter')) return Icons.liquor_rounded;
    if (n.contains('cocktail') || n.contains('spritz') || n.contains('gin') || n.contains('negroni')) return Icons.local_bar_rounded;
    return Icons.local_drink_rounded;
  }

  // Popup informativo con le disclaimer e gli effetti del BAC
  void _showBacInfoDialog(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.orange),
            const SizedBox(width: 8),
            Text(loc.infoResponsibilityTitle),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                loc.bacDisclaimer,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.redAccent),
              ),
              const Divider(height: 24),
              Text(loc.estimatedEffectsTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _buildBacRangeRow("0.01 - 0.05", loc.bacEffect1),
              _buildBacRangeRow("0.05 - 0.08", loc.bacEffect2),
              _buildBacRangeRow("0.08 - 0.15", loc.bacEffect3),
              _buildBacRangeRow("0.15 - 0.30", loc.bacEffect4),
              _buildBacRangeRow(loc.over30, loc.bacEffect5),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(loc.gotItBtn),
          ),
        ],
      ),
    );
  }

  Widget _buildBacRangeRow(String range, String effect) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 13, color: Colors.black87),
          children: [
            TextSpan(text: "$range g/l: ", style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: effect),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final user = ref.watch(userProvider);
    final drinks = ref.watch(drinksProvider);
    final theme = Theme.of(context);

    // Filtro ultime 24 ore per la UI (il BAC usa comunque tutti i drink per la stima)
    final now = DateTime.now();
    final recentDrinks = drinks.where((d) => now.difference(d.timestamp).inHours <= 24).toList();

    final currentBac = BacCalculator.calculateCurrentBAC(drinks, user);
    final isOverLimit = currentBac > user.legalLimit;

    // --- CALCOLO ACQUA CONSIGLIATA ---
    double totalAlcoholGrams = 0.0;
    for (var d in recentDrinks) {
      totalAlcoholGrams += d.volume * (d.abv / 100) * 0.8;
    }
    int recommendedWaterMl = ((totalAlcoholGrams / 10) * 250).round();
    int recommendedWaterGlasses = (recommendedWaterMl / 250).ceil();

    // --- ANIMAZIONE FLUIDA (La Chiave Magica) ---
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
    final targetTimeText = DateFormat('HH:mm').format(targetDateTime);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined), 
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen())),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),
            
            // --- CERCHIO CON ANIMAZIONE NATIVA FLUIDA ---
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
                  backgroundColor: Colors.grey[200]!,
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
                          "${timerDuration.inHours}h ${timerDuration.inMinutes.remainder(60)}m ${timerDuration.inSeconds.remainder(60)}s",
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
            
            const SizedBox(height: 24),
            
            // --- WARNING CLICKABILE PER INFO BAC ---
            if (isOverLimit) ...[
              GestureDetector(
                onTap: () => _showBacInfoDialog(context),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(color: Colors.red[50], borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 20),
                      const SizedBox(width: 8),
                      Text(loc.overLimitWarning, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 4),
                      const Icon(Icons.info_outline, color: Colors.red, size: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

// --- INDICATORE ACQUA CONSIGLIATA ---
            if (totalAlcoholGrams > 0) ...[
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isWaterDrank = !_isWaterDrank;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    // Cambia colore in verde se l'acqua è stata bevuta
                    color: _isWaterDrank ? Colors.green[50] : Colors.blue[50], 
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _isWaterDrank ? Colors.green[200]! : Colors.blue[100]!
                    )
                  ),
                  child: Row(
                    children: [
                      // Cambia l'icona se spuntato
                      Icon(
                        _isWaterDrank ? Icons.check_circle_rounded : Icons.water_drop_rounded, 
                        color: _isWaterDrank ? Colors.green[400] : Colors.blue[400], 
                        size: 32
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              loc.hydrationTitle, 
                              style: TextStyle(
                                color: _isWaterDrank ? Colors.green[800] : Colors.blue[800], 
                                fontWeight: FontWeight.bold,
                                decoration: _isWaterDrank ? TextDecoration.lineThrough : null, // Sbarra il testo se fatto
                              )
                            ),
                            const SizedBox(height: 2),
                            Text(
                              loc.hydrationAdvice(recommendedWaterMl, recommendedWaterGlasses), 
                              style: TextStyle(
                                color: _isWaterDrank ? Colors.green[700] : Colors.blue[700], 
                                fontSize: 13, 
                                height: 1.2,
                                decoration: _isWaterDrank ? TextDecoration.lineThrough : null,
                              )
                            ),
                          ],
                        ),
                      ),
                      // <-- LA TUA CHECKBOX
                      Checkbox(
                        value: _isWaterDrank,
                        activeColor: Colors.green,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        onChanged: (bool? value) {
                          setState(() {
                            _isWaterDrank = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            
            // --- DISCLAIMER PICCOLO GENERALE ---
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[300]!)),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 18, color: Colors.grey[700]),
                  const SizedBox(width: 10),
                  Expanded(child: Text(loc.disclaimer, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54))),
                ],
              ),
            ), 
            
            const SizedBox(height: 24),
            
            // --- HEADER LISTA DRINK ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("${loc.todayDrinks} (24h)", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ),
            ),
            
            const SizedBox(height: 8),
            
            // --- LISTA DRINK RECENTI ---
            Expanded(
              child: recentDrinks.isEmpty
                  ? Center(child: Text(loc.noDrinks, style: TextStyle(color: Colors.grey[500], fontSize: 16)))
                  : ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
                      itemCount: recentDrinks.length,
                      itemBuilder: (context, index) {
                        final drink = recentDrinks[recentDrinks.length - 1 - index];
                        return Dismissible(
                          key: Key(drink.id),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) => ref.read(drinksProvider.notifier).removeDrink(drink.id),
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(color: Colors.red[400], borderRadius: BorderRadius.circular(16)),
                            child: const Icon(Icons.delete_sweep, color: Colors.white, size: 28),
                          ),
                          child: Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
                                  builder: (context) => Padding(
                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: AddDrinkBottomSheet(drinkToEdit: drink), 
                                  ),
                                );
                              },
                              leading: CircleAvatar(
                                backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                                child: Icon(_getDrinkIcon(drink.name), color: theme.colorScheme.primary),
                              ),
                              title: Text(_getTranslatedDrinkName(drink.name, loc), style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text("${drink.volume.toInt()} ml • ${drink.abv.toStringAsFixed(2)}% ABV"),
                              trailing: Text(DateFormat('HH:mm').format(drink.timestamp), style: const TextStyle(color: Colors.grey)),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}