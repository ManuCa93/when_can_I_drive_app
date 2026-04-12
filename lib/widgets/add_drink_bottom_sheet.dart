import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/drink_log.dart';
import '../providers/app_providers.dart';
import '../l10n/app_localizations.dart';

class AddDrinkBottomSheet extends ConsumerStatefulWidget {
  final DrinkLog? drinkToEdit;

  const AddDrinkBottomSheet({super.key, this.drinkToEdit});

  @override
  ConsumerState<AddDrinkBottomSheet> createState() => _AddDrinkBottomSheetState();
}

class _AddDrinkBottomSheetState extends ConsumerState<AddDrinkBottomSheet> {
  late StomachState _stomachState;
  late double _hoursSinceMeal;
  late String _selectedCategory;
  late String _drinkName;
  late double _volume;
  late double _abv;

  final Map<String, Map<String, double>> _categories = {
    'Birra': {'vol': 330, 'abv': 5.0},
    'Vino': {'vol': 150, 'abv': 12.0},
    'Shot': {'vol': 40, 'abv': 40.0},
    'Amaro': {'vol': 60, 'abv': 30.0},
    'Cocktail': {'vol': 150, 'abv': 15.0},
  };

  final Map<String, Map<String, double>> _cocktails = {
    'Spritz': {'vol': 150, 'abv': 11.0},
    'Gin Tonic': {'vol': 150, 'abv': 15.0},
    'Negroni': {'vol': 90, 'abv': 25.0},
    'Long Island': {'vol': 200, 'abv': 22.0},
  };

  @override
  void initState() {
    super.initState();
    if (widget.drinkToEdit != null) {
      final d = widget.drinkToEdit!;
      _stomachState = d.stomachState;
      _hoursSinceMeal = d.hoursSinceMeal;
      _drinkName = d.name;
      _volume = d.volume;
      _abv = d.abv;
      _selectedCategory = _categories.containsKey(d.name) ? d.name : 'Cocktail';
    } else {
      _stomachState = StomachState.normal;
      _hoursSinceMeal = 1.0;
      _selectedCategory = 'Birra';
      _drinkName = 'Birra';
      _volume = 330.0;
      _abv = 5.0;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Birra': return Icons.sports_bar_rounded;
      case 'Vino': return Icons.wine_bar_rounded;
      case 'Shot':
      case 'Amaro': return Icons.liquor_rounded;
      case 'Cocktail': return Icons.local_bar_rounded;
      default: return Icons.local_drink_rounded;
    }
  }

  // Helper per tradurre le categorie
  String _translateCat(String cat, AppLocalizations loc) {
    switch (cat) {
      case 'Birra': return loc.beer;
      case 'Vino': return loc.wine;
      case 'Shot': return loc.shot;
      case 'Amaro': return loc.amaro;
      default: return loc.cocktail;
    }
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _drinkName = category; // Salviamo il nome "chiave" (es: Birra)
      _volume = _categories[category]!['vol']!;
      _abv = _categories[category]!['abv']!;
    });
  }

  void _saveDrink() {
    final drink = DrinkLog(
      id: widget.drinkToEdit?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: _drinkName,
      volume: _volume,
      abv: _abv,
      timestamp: widget.drinkToEdit?.timestamp ?? DateTime.now(),
      stomachState: _stomachState,
      hoursSinceMeal: _hoursSinceMeal,
    );

    if (widget.drinkToEdit != null) {
      ref.read(drinksProvider.notifier).updateDrink(drink);
    } else {
      ref.read(drinksProvider.notifier).addDrink(drink);
    }
    Navigator.pop(context);
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
    String displayValue = (unit.contains("%")) ? value.toStringAsFixed(2) : (value == value.toInt() ? value.toInt().toString() : value.toStringAsFixed(1));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title: $displayValue $unit", style: const TextStyle(fontWeight: FontWeight.w600)),
        Row(
          children: [
            IconButton(icon: const Icon(Icons.remove_circle_outline), color: theme.colorScheme.primary, onPressed: value > min ? () => onChanged((value - step).clamp(min, max)) : null),
            Expanded(child: Slider(value: value, min: min, max: max, activeColor: theme.colorScheme.secondary, onChanged: onChanged)),
            IconButton(icon: const Icon(Icons.add_circle_outline), color: theme.colorScheme.primary, onPressed: value < max ? () => onChanged((value + step).clamp(min, max)) : null),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    final isEditing = widget.drinkToEdit != null; 

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 24),
            Row(
              children: [
                Icon(_getCategoryIcon(_selectedCategory), color: theme.colorScheme.primary, size: 28),
                const SizedBox(width: 12),
                Text(isEditing ? "Edit" : loc.addDrinkTitle, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 24),

            // --- STOMACO TRADOTTO ---
            Text(loc.stomachStatus, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: SegmentedButton<StomachState>(
                segments: [
                  ButtonSegment(value: StomachState.empty, label: Text(loc.stomachEmpty)),
                  ButtonSegment(value: StomachState.normal, label: Text(loc.stomachNormal)),
                  ButtonSegment(value: StomachState.full, label: Text(loc.stomachFull)),
                ],
                selected: {_stomachState},
                onSelectionChanged: (newSelection) => setState(() => _stomachState = newSelection.first),
              ),
            ),
            if (_stomachState == StomachState.full) ...[
              const SizedBox(height: 16),
              _buildPreciseSlider(
                title: loc.hoursSinceMeal, 
                value: _hoursSinceMeal, min: 0, max: 4, step: 0.5, unit: "h", theme: theme,
                onChanged: (val) => setState(() => _hoursSinceMeal = val),
              ),
            ],
            const Divider(height: 40),

            // --- CATEGORIA TRADOTTA ---
            Text(loc.cocktail, style: const TextStyle(fontWeight: FontWeight.w600)), // Usiamo loc.cocktail o una stringa generica
            const SizedBox(height: 12),
            Wrap(
              spacing: 8, runSpacing: 8,
              children: _categories.keys.map((cat) {
                final isSelected = _selectedCategory == cat;
                return ChoiceChip(
                  avatar: Icon(_getCategoryIcon(cat), size: 16, color: isSelected ? theme.colorScheme.primary : Colors.grey),
                  label: Text(_translateCat(cat, loc)), // Traduzione della categoria
                  selected: isSelected,
                  selectedColor: theme.colorScheme.primary.withOpacity(0.15),
                  onSelected: (_) => _selectCategory(cat),
                );
              }).toList(),
            ),
            
            if (_selectedCategory == 'Cocktail') ...[
              const SizedBox(height: 16),
              SizedBox(
                height: 45,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _cocktails.keys.map((cocktail) {
                    final isSelected = _drinkName == cocktail;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ActionChip(
                        label: Text(cocktail),
                        backgroundColor: isSelected ? theme.colorScheme.primary : Colors.grey[100],
                        labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
                        onPressed: () => setState(() {
                          _drinkName = cocktail;
                          _volume = _cocktails[cocktail]!['vol']!;
                          _abv = _cocktails[cocktail]!['abv']!;
                        }),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
            const Divider(height: 40),

            // --- SLIDER TRADOTTI ---
            _buildPreciseSlider(
              title: loc.volume,
              value: _volume, min: 20, max: 1000, step: 10, unit: "ml", theme: theme,
              onChanged: (val) => setState(() => _volume = val),
            ),
            
            _buildPreciseSlider(
              title: loc.abv,
              value: _abv, min: 1, max: 80, step: 0.5, unit: "% ABV", theme: theme,
              onChanged: (val) => setState(() => _abv = val),
            ),
            
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity, height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                onPressed: _saveDrink,
                child: Text(isEditing ? loc.saveBtn : loc.addBtn, 
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}