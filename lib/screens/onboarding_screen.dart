import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_profile.dart';
import '../providers/app_providers.dart';
import '../utils/notification_service.dart';
import '../l10n/app_localizations.dart'; // <-- IMPORT DELLE TRADUZIONI

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  double _weight = 70;
  double _height = 170;
  int _age = 25;
  String _gender = 'M';
  bool _isNewDriver = false;
  bool _acceptedDisclaimer = false;

  Widget _buildPreciseSlider({
    required String title,
    required double value,
    required double min,
    required double max,
    required double step,
    required String unit,
    required ValueChanged<double> onChanged,
    required ThemeData theme,
  }) {
    String displayValue = value == value.toInt() ? value.toInt().toString() : value.toStringAsFixed(1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title: $displayValue $unit", style: const TextStyle(fontWeight: FontWeight.w600)),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline), color: theme.colorScheme.primary,
              onPressed: value > min ? () => onChanged((value - step).clamp(min, max)) : null,
            ),
            Expanded(
              child: Slider(value: value, min: min, max: max, activeColor: theme.colorScheme.secondary, onChanged: onChanged),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline), color: theme.colorScheme.primary,
              onPressed: value < max ? () => onChanged((value + step).clamp(min, max)) : null,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!; // <-- MAGIA DELLE LINGUE ATTIVATA
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Icon(Icons.health_and_safety, size: 64, color: theme.colorScheme.primary),
                  const SizedBox(height: 16),
                  
                  // Titolo e sottotitolo tradotti
                  Text(loc.welcomeTitle, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(loc.welcomeSubtitle, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 32),
                  
                  // Selettore sesso tradotto
                  SegmentedButton<String>(
                    segments: [
                      ButtonSegment(
                        value: 'M', 
                        icon: const Icon(Icons.male), // <-- AGGIUNTA ICONA
                        label: Text(loc.male)
                      ),
                      ButtonSegment(
                        value: 'F', 
                        icon: const Icon(Icons.female), // <-- AGGIUNTA ICONA
                        label: Text(loc.female)
                      ),
                    ],
                    selected: {_gender},
                    onSelectionChanged: (set) => setState(() => _gender = set.first),
                  ),
                  const SizedBox(height: 32),
                  
                  // Slider con titoli e unità di misura tradotte
                  _buildPreciseSlider(title: loc.weightLabel, value: _weight, min: 40, max: 150, step: 1, unit: loc.unitKg, theme: theme, onChanged: (v) => setState(() => _weight = v)),
                  const SizedBox(height: 16),
                  _buildPreciseSlider(title: loc.heightLabel, value: _height, min: 140, max: 220, step: 1, unit: loc.unitCm, theme: theme, onChanged: (v) => setState(() => _height = v)),
                  const SizedBox(height: 16),
                  _buildPreciseSlider(title: loc.ageLabel, value: _age.toDouble(), min: 18, max: 99, step: 1, unit: loc.unitYears, theme: theme, onChanged: (v) => setState(() => _age = v.toInt())),
                  
                  const SizedBox(height: 24),
                  
                  // Neopatentato Switch
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(color: theme.colorScheme.primaryContainer.withOpacity(0.3), borderRadius: BorderRadius.circular(12)),
                    child: SwitchListTile(
                      activeColor: theme.colorScheme.primary,
                      title: Text(loc.newDriver, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(loc.newDriverDesc, style: const TextStyle(fontSize: 12)),
                      value: _isNewDriver,
                      onChanged: (val) => setState(() => _isNewDriver = val),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Disclaimer tradotto
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: theme.colorScheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                    child: CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: theme.colorScheme.primary,
                      title: Text(
                        loc.onboardingDisclaimer,
                        style: const TextStyle(fontSize: 12),
                      ),
                      value: _acceptedDisclaimer,
                      onChanged: (bool? value) {
                        setState(() => _acceptedDisclaimer = value ?? false);
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Bottone "Inizia" tradotto
                  SizedBox(
                    width: double.infinity, height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: _acceptedDisclaimer ? () async {
                        await NotificationService.requestPermissions();
                        ref.read(userProvider.notifier).state = UserProfile(
                          weight: _weight, height: _height, age: _age, gender: _gender, isNewDriver: _isNewDriver, isOnboarded: true
                        );
                      } : null,
                      child: Text(loc.startBtn, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}