// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'SoberTrack';

  @override
  String get currentBac => 'Current BAC';

  @override
  String get soberAt => 'Sober at';

  @override
  String get underLimitAt => 'Under limit at';

  @override
  String get youAreSober => 'You are sober!';

  @override
  String get overLimitWarning => 'You are over the driving limit!';

  @override
  String get todayDrinks => 'Today\'s Drinks';

  @override
  String get noDrinks => 'No drinks today. Great!';

  @override
  String get disclaimer =>
      'WARNING: Mathematical estimate. Do not replace real breathalyzers. Never drink and drive.';

  @override
  String get statusUnder => '🟢 Under limit';

  @override
  String get statusOver => '🔴 Over limit';

  @override
  String get estimatedTime => 'Estimated time:';

  @override
  String get historyTitle => 'BAC Trend';

  @override
  String get drinkHistory => 'Drink History';

  @override
  String get noDataAvailable => 'No data available';

  @override
  String get addDrinkTitle => 'Add Drink';

  @override
  String get drinkName => 'Name (e.g. Beer)';

  @override
  String get volume => 'Volume (ml)';

  @override
  String get abv => 'Alcohol (%)';

  @override
  String get addBtn => 'Add';

  @override
  String get cancelBtn => 'Cancel';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get physicalProfile => 'Physical Profile';

  @override
  String get weight => 'Weight (kg)';

  @override
  String get height => 'Height (cm)';

  @override
  String get age => 'Age';

  @override
  String get gender => 'Gender (M/F)';

  @override
  String get legalLimit => 'Legal Limit (g/l)';

  @override
  String get saveBtn => 'Save';

  @override
  String get welcomeTitle => 'Welcome to SoberTrack';

  @override
  String get welcomeSubtitle =>
      'Enter your details for an accurate calculation.';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get weightLabel => 'Weight';

  @override
  String get heightLabel => 'Height';

  @override
  String get ageLabel => 'Age';

  @override
  String get unitKg => 'kg';

  @override
  String get unitCm => 'cm';

  @override
  String get unitYears => 'years';

  @override
  String get onboardingDisclaimer =>
      'I understand that the values shown are mathematical estimates and do not replace a real breathalyzer. I will not drink and drive.';

  @override
  String get startBtn => 'Start';

  @override
  String get settingsSubtitle =>
      'Edit your physical data to recalculate your BAC.';

  @override
  String get stomachStatus => 'Stomach status';

  @override
  String get stomachEmpty => 'Empty';

  @override
  String get stomachNormal => 'Normal';

  @override
  String get stomachFull => 'Full';

  @override
  String get hoursSinceMeal => 'Hours since meal';

  @override
  String get beer => 'Beer';

  @override
  String get wine => 'Wine';

  @override
  String get shot => 'Shot';

  @override
  String get amaro => 'Bitter';

  @override
  String get cocktail => 'Cocktail';

  @override
  String get customDates => 'Dates';

  @override
  String get infoResponsibilityTitle => 'Info & Responsibility';

  @override
  String get bacDisclaimer =>
      'DISCLAIMER: This app provides theoretical estimates. Alcohol metabolism varies based on genetics, weight, food intake, and health. NEVER drive or make important decisions after consuming alcohol. Always use common sense and do not entrust your life to an app.';

  @override
  String get estimatedEffectsTitle => 'Estimated effects by BAC range:';

  @override
  String get bacEffect1 =>
      'Mild relaxation, slight euphoria. No noticeable deficits. (New drivers/professionals: fines and points deduction).';

  @override
  String get bacEffect2 =>
      'Lowered inhibitions, slowed reflexes. Driving impaired. (Standard drivers: heavy fines, license suspension. Penalties doubled in case of an accident).';

  @override
  String get bacEffect3 =>
      'Poor coordination, altered balance and vision. (Severe fines, possible imprisonment up to 6 months, license suspension 6-12 months).';

  @override
  String get bacEffect4 =>
      'Severe confusion, nausea, difficulty speaking and walking. (Maximum fines, imprisonment 6-12 months, license suspension 1-2 years, vehicle confiscation).';

  @override
  String get bacEffect5 =>
      'Severe risk of intoxication, possible loss of consciousness. (As above, with immediate license revocation. Extreme risk of coma or death).';

  @override
  String get over30 => 'Over 0.30';

  @override
  String get gotItBtn => 'Got it';

  @override
  String get hydrationTitle => 'Recommended Hydration';

  @override
  String hydrationAdvice(int ml, int glasses) {
    return 'Drink at least $ml ml of water (about $glasses glasses) to support recovery.';
  }

  @override
  String get newDriver => 'New Driver';

  @override
  String get newDriverDesc =>
      'Sets the legal limit to 0.0 g/l (can be changed in settings)';
}
