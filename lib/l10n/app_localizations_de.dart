// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Enjoy the Night';

  @override
  String get currentBac => 'Aktuelle BAK';

  @override
  String get soberAt => 'Nüchtern um';

  @override
  String get underLimitAt => 'Unter Limit um';

  @override
  String get youAreSober => 'Du darfst fahren!';

  @override
  String get overLimitWarning => 'Du bist über dem Limit!';

  @override
  String get todayDrinks => 'Heutige Drinks';

  @override
  String get noDrinks => 'Keine Drinks heute. Super!';

  @override
  String get disclaimer =>
      'WARNUNG: Mathematische Schätzung. Ersetzt keinen echten Alkoholtester. Trinken und Fahren verboten.';

  @override
  String get statusUnder => 'Unter Limit';

  @override
  String get statusOver => 'Über Limit';

  @override
  String get estimatedTime => 'Geschätzte Zeit:';

  @override
  String get historyTitle => 'BAK-Trend';

  @override
  String get drinkHistory => 'Drink-Historie';

  @override
  String get noDataAvailable => 'Keine Daten verfügbar';

  @override
  String get addDrinkTitle => 'Drink hinzufügen';

  @override
  String get drinkName => 'Name (z.B. Bier)';

  @override
  String get volume => 'Menge (ml)';

  @override
  String get abv => 'Alkohol (%)';

  @override
  String get addBtn => 'Hinzufügen';

  @override
  String get cancelBtn => 'Abbrechen';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get physicalProfile => 'Physisches Profil';

  @override
  String get weight => 'Gewicht (kg)';

  @override
  String get height => 'Größe (cm)';

  @override
  String get age => 'Alter';

  @override
  String get gender => 'Geschlecht (M/W)';

  @override
  String get legalLimit => 'Gesetzliches Limit (g/l)';

  @override
  String get saveBtn => 'Speichern';

  @override
  String get welcomeTitle => 'Willkommen bei Enjoy the Night';

  @override
  String get welcomeSubtitle =>
      'Geben Sie Ihre Daten für eine genaue Berechnung ein.';

  @override
  String get male => 'Männlich';

  @override
  String get female => 'Weiblich';

  @override
  String get weightLabel => 'Gewicht';

  @override
  String get heightLabel => 'Größe';

  @override
  String get ageLabel => 'Alter';

  @override
  String get unitKg => 'kg';

  @override
  String get unitCm => 'cm';

  @override
  String get unitYears => 'Jahre';

  @override
  String get onboardingDisclaimer =>
      'Ich verstehe, dass die angezeigten Werte mathematische Schätzungen sind und keinen Alkoholtester ersetzen. Ich werde nicht trinken und fahren.';

  @override
  String get startBtn => 'Start';

  @override
  String get settingsSubtitle =>
      'Bearbeiten Sie Ihre Daten, um Ihre BAK neu zu berechnen.';

  @override
  String get stomachStatus => 'Magenstatus';

  @override
  String get stomachEmpty => 'Leer';

  @override
  String get stomachNormal => 'Normal';

  @override
  String get stomachFull => 'Voll';

  @override
  String get hoursSinceMeal => 'Stunden seit Mahlzeit';

  @override
  String get beer => 'Bier';

  @override
  String get wine => 'Wein';

  @override
  String get shot => 'Shot';

  @override
  String get amaro => 'Kräuterlikör';

  @override
  String get cocktail => 'Cocktail';

  @override
  String get customDates => 'Daten';

  @override
  String get infoResponsibilityTitle => 'Info & Verantwortung';

  @override
  String get bacDisclaimer =>
      'HAFTUNGSAUSSCHLUSS: Diese App liefert theoretische Schätzungen. Der Alkoholabbau variiert nach Genetik, Gewicht, Nahrung und Gesundheit. Fahren Sie NIE unter Alkoholeinfluss. Verlassen Sie sich nicht nur auf eine App.';

  @override
  String get estimatedEffectsTitle => 'Geschätzte Effekte nach BAK:';

  @override
  String get bacEffect1 =>
      'Leichte Entspannung, leichte Euphorie. Keine merklichen Defizite. (Fahranfänger: Bußgelder und Punkte).';

  @override
  String get bacEffect2 =>
      'Geringere Hemmungen, verlangsamte Reflexe. Fahruntüchtigkeit. (Hohe Bußgelder, Führerscheinentzug).';

  @override
  String get bacEffect3 =>
      'Schlechte Koordination, verändertes Gleichgewicht. (Schwere Strafen, möglicher Gefängnisaufenthalt, Führerscheinentzug).';

  @override
  String get bacEffect4 =>
      'Schwere Verwirrung, Übelkeit, Sprach- und Gehschwierigkeiten. (Maximale Strafen, Gefängnis, Fahrzeugbeschlagnahmung).';

  @override
  String get bacEffect5 =>
      'Schweres Risiko einer Vergiftung, möglicher Bewusstseinsverlust. (Wie oben, Koma- oder Todesrisiko).';

  @override
  String get over30 => 'Über 0.30';

  @override
  String get gotItBtn => 'Verstanden';

  @override
  String get hydrationTitle => 'Empfohlene Flüssigkeitszufuhr';

  @override
  String hydrationAdvice(int ml, int glasses) {
    return 'Trinken Sie mindestens $ml ml Wasser (ca. $glasses Gläser) zur Unterstützung.';
  }

  @override
  String get newDriver => 'Fahranfänger';

  @override
  String get newDriverDesc =>
      'Setzt das Limit auf 0,0 g/l (kann in den Einstellungen geändert werden)';

  @override
  String get prosecco => 'Prosecco';

  @override
  String get themeTitle => 'App Design';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get glassesCount => 'Anzahl der Gläser';

  @override
  String get manualEdit => 'Manuelle Eingabe';

  @override
  String get favoritesTitle => 'Favoriten';

  @override
  String get savedToFavorites => 'Zu Favoriten hinzugefügt';

  @override
  String get removedFromFavorites => 'Aus Favoriten entfernt';

  @override
  String get editDrinkTitle => 'Drink bearbeiten';

  @override
  String get limitLabel => 'Limit';

  @override
  String get calculationExplanationTitle => 'Wie wird die BAK berechnet?';

  @override
  String get calculationExplanationBody =>
      'Diese App verwendet die modifizierte Widmark-Formel, um Ihre Blutalkoholkonzentration (BAK) mathematisch zu schätzen.\n\nWAS DIE BERECHNUNG BEEINFLUSST:\n• Gewicht und Geschlecht (sie bestimmen den Wassergehalt in Ihrem Körper).\n• Volumen und Alkoholgehalt.\n• Magenzustand ZUM ZEITPUNKT des Trinkens (Nahrung verlangsamt die Alkoholaufnahme).\n\nWAS SIE NICHT BEEINFLUSST (Mythen):\n• Essen NACH dem Trinken: Der Alkohol ist bereits im Blutkreislauf, Nahrung absorbiert ihn nicht und hilft der Leber nicht beim Abbau.\n• Kaffee trinken, kalt duschen oder viel Wasser trinken (Wasser verhindert Dehydration, senkt aber nicht die BAK).\n• Nur ZEIT ermöglicht es der Leber, Alkohol abzubauen (ca. 0,15 g/l pro Stunde).';

  @override
  String get timeFormatTitle => '24-hour Time';

  @override
  String get timeFormatDesc =>
      'Switch between 12-hour (AM/PM) and 24-hour time format';
}
