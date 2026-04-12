import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_profile.dart';
import '../providers/app_providers.dart';
import '../l10n/app_localizations.dart'; // <-- IMPORT DELLE TRADUZIONI

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late double _weight;
  late double _height;
  late int _age;
  late String _gender;

  @override
  void initState() {
    super.initState();
    // Recuperiamo i dati attuali per pre-compilare gli slider
    final currentUser = ref.read(userProvider);
    _weight = currentUser.weight;
    _height = currentUser.height;
    _age = currentUser.age;
    _gender = currentUser.gender;
  }

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
    final loc = AppLocalizations.of(context)!; // <-- INIZIALIZZAZIONE LINGUA

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.settingsTitle), // TRADOTTO
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(loc.settingsSubtitle, style: const TextStyle(color: Colors.grey)), // TRADOTTO
                const SizedBox(height: 32),
                
                Text(loc.gender, style: const TextStyle(fontWeight: FontWeight.w600)), // TRADOTTO (Sesso)
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<String>(
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
                ),
                const SizedBox(height: 32),
                
                // TRADOTTO TUTTO: Titoli e unità di misura
                _buildPreciseSlider(title: loc.weightLabel, value: _weight, min: 40, max: 150, step: 1, unit: loc.unitKg, theme: theme, onChanged: (v) => setState(() => _weight = v)),
                const SizedBox(height: 16),
                _buildPreciseSlider(title: loc.heightLabel, value: _height, min: 140, max: 220, step: 1, unit: loc.unitCm, theme: theme, onChanged: (v) => setState(() => _height = v)),
                const SizedBox(height: 16),
                _buildPreciseSlider(title: loc.ageLabel, value: _age.toDouble(), min: 18, max: 99, step: 1, unit: loc.unitYears, theme: theme, onChanged: (v) => setState(() => _age = v.toInt())),
                
                const SizedBox(height: 40),
                
                SizedBox(
                  width: double.infinity, height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      // Salviamo i nuovi dati e torniamo indietro
                      ref.read(userProvider.notifier).state = UserProfile(
                        weight: _weight, height: _height, age: _age, gender: _gender, isOnboarded: true
                      );
                      Navigator.pop(context);
                    },
                    child: Text(loc.saveBtn, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), // TRADOTTO
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}