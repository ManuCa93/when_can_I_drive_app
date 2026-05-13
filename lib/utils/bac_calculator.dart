import '../models/drink_log.dart';
import '../models/user_profile.dart';

class BacCalculator {
  // Tasso di smaltimento medio (0.15 g/l all'ora)
  static const double metabolismRate = 0.15;

  static double calculateCurrentBAC(List<DrinkLog> drinks, UserProfile user) {
    if (drinks.isEmpty) return 0.0;

    // Ordiniamo i drink per timestamp per calcolare lo smaltimento sequenziale
    final sortedDrinks = List<DrinkLog>.from(drinks)
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    double currentBac = 0.0;
    DateTime lastTime = sortedDrinks.first.timestamp;
    final r = user.gender == 'M' ? 0.68 : 0.55;

    for (final drink in sortedDrinks) {
      // 1. Smaltiamo l'alcol accumulato nel tempo trascorso tra il drink precedente e questo
      final intervalSeconds = drink.timestamp.difference(lastTime).inSeconds;
      if (intervalSeconds > 0) {
        final intervalHours = intervalSeconds / 3600.0;
        currentBac = (currentBac - (metabolismRate * intervalHours)).clamp(0.0, double.infinity);
      }

      // 2. Aggiungiamo il nuovo drink
      final gramsAlcohol = drink.volume * (drink.abv / 100) * 0.8;
      currentBac += gramsAlcohol / (user.weight * r);

      lastTime = drink.timestamp;
    }

    // 3. Smaltiamo l'alcol accumulato tra l'ultimo drink e "ora"
    final now = DateTime.now();
    final finalIntervalSeconds = now.difference(lastTime).inSeconds;
    if (finalIntervalSeconds > 0) {
      final finalIntervalHours = finalIntervalSeconds / 3600.0;
      currentBac = (currentBac - (metabolismRate * finalIntervalHours)).clamp(0.0, double.infinity);
    }

    return currentBac;
  }

  // Calcola il tempo per tornare a 0.0 BAC
  static Duration timeUntilSober(double currentBac) {
    if (currentBac <= 0) return Duration.zero;
    
    // Calcoliamo le ore e le convertiamo direttamente in SECONDI totali
    final totalSeconds = (currentBac / metabolismRate) * 3600;
    
    // Creiamo la Duration a partire dai secondi (così ha i secondi esatti da mostrare nell'UI)
    return Duration(seconds: totalSeconds.toInt());
  }

  // Calcola il tempo per scendere sotto il limite legale
  static Duration timeUntilLegalLimit(double currentBac, double legalLimit) {
    if (currentBac <= legalLimit) return Duration.zero;
    
    final totalSeconds = ((currentBac - legalLimit) / metabolismRate) * 3600;
    
    return Duration(seconds: totalSeconds.toInt());
  }

  // Aggiungi questo metodo statico
  static double calculateBACAtTime(List<DrinkLog> drinks, UserProfile user, DateTime timePoint) {
    if (drinks.isEmpty) return 0.0;

    // Filtriamo e ordiniamo i drink bevuti PRIMA del punto temporale richiesto
    final relevantDrinks = drinks.where((d) => !d.timestamp.isAfter(timePoint)).toList();
    if (relevantDrinks.isEmpty) return 0.0;
    
    relevantDrinks.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    double currentBac = 0.0;
    DateTime lastTime = relevantDrinks.first.timestamp;
    final r = user.gender == 'M' ? 0.68 : 0.55;

    for (final drink in relevantDrinks) {
      final intervalSeconds = drink.timestamp.difference(lastTime).inSeconds;
      if (intervalSeconds > 0) {
        final intervalHours = intervalSeconds / 3600.0;
        currentBac = (currentBac - (metabolismRate * intervalHours)).clamp(0.0, double.infinity);
      }

      final gramsAlcohol = drink.volume * (drink.abv / 100) * 0.8;
      currentBac += gramsAlcohol / (user.weight * r);

      lastTime = drink.timestamp;
    }

    final finalIntervalSeconds = timePoint.difference(lastTime).inSeconds;
    if (finalIntervalSeconds > 0) {
      final finalIntervalHours = finalIntervalSeconds / 3600.0;
      currentBac = (currentBac - (metabolismRate * finalIntervalHours)).clamp(0.0, double.infinity);
    }

    return currentBac;
  }
}