import 'package:flutter/material.dart';

class DrinkIcons {
  static IconData getIconForDrink(String name) {
    final n = name.toLowerCase();
    if (n.contains('birra') || n.contains('beer')) return Icons.sports_bar_rounded;
    if (n.contains('vino') || n.contains('wine')) return Icons.wine_bar_rounded;
    if (n.contains('shot') || n.contains('amaro') || n.contains('bitter')) return Icons.liquor_rounded;
    if (n.contains('cocktail') || n.contains('spritz') || n.contains('gin') || n.contains('negroni')) return Icons.local_bar_rounded;
    return Icons.local_drink_rounded; // Default
  }
}