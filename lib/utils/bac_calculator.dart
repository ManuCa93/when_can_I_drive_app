import '../models/drink_log.dart';
import '../models/user_profile.dart';

class BacCalculator {
  // Tasso di smaltimento medio (0.15 g/l all'ora)
  static const double metabolismRate = 0.15;

  static double calculateCurrentBAC(List<DrinkLog> drinks, UserProfile user) {
    if (drinks.isEmpty) return 0.0;

    double totalBac = 0.0;
    final now = DateTime.now();

    // Costante di Widmark: 0.68 per gli uomini, 0.55 per le donne
    final r = user.gender == 'M' ? 0.68 : 0.55;

    for (final drink in drinks) {
      // Grammi di alcol = Volume (ml) * (ABV / 100) * 0.8 (densità dell'alcol)
      final gramsAlcohol = drink.volume * (drink.abv / 100) * 0.8;
      
      // BAC teorico iniziale per questo drink
      final drinkBac = gramsAlcohol / (user.weight * r);

      // --- IL SEGRETO È QUI: Usiamo i SECONDI invece dei minuti o delle ore! ---
      final elapsedSeconds = now.difference(drink.timestamp).inSeconds;
      if (elapsedSeconds < 0) continue; // Ignora drink futuri per sicurezza
      
      final elapsedHours = elapsedSeconds / 3600.0;

      // Alcol smaltito finora
      final metabolizedBac = metabolismRate * elapsedHours;

      // BAC rimanente per questo singolo drink
      final remainingBac = drinkBac - metabolizedBac;
      
      if (remainingBac > 0) {
        totalBac += remainingBac;
      }
    }

    return totalBac > 0 ? totalBac : 0.0;
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
    double totalBac = 0.0;
    final r = user.gender == 'M' ? 0.68 : 0.55;

    for (final drink in drinks) {
      // Calcoliamo solo i drink bevuti PRIMA del punto temporale richiesto
      if (drink.timestamp.isAfter(timePoint)) continue;

      final gramsAlcohol = drink.volume * (drink.abv / 100) * 0.8;
      final drinkBac = gramsAlcohol / (user.weight * r);
      
      final elapsedSeconds = timePoint.difference(drink.timestamp).inSeconds;
      final elapsedHours = elapsedSeconds / 3600.0;
      final metabolizedBac = metabolismRate * elapsedHours;

      final remainingBac = drinkBac - metabolizedBac;
      if (remainingBac > 0) {
        totalBac += remainingBac;
      }
    }
    return totalBac > 0 ? totalBac : 0.0;
  }
}