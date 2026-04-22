import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('it')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'SoberTrack'**
  String get appTitle;

  /// No description provided for @currentBac.
  ///
  /// In en, this message translates to:
  /// **'Current BAC'**
  String get currentBac;

  /// No description provided for @soberAt.
  ///
  /// In en, this message translates to:
  /// **'Sober at'**
  String get soberAt;

  /// No description provided for @underLimitAt.
  ///
  /// In en, this message translates to:
  /// **'Under limit at'**
  String get underLimitAt;

  /// No description provided for @youAreSober.
  ///
  /// In en, this message translates to:
  /// **'You are sober!'**
  String get youAreSober;

  /// No description provided for @overLimitWarning.
  ///
  /// In en, this message translates to:
  /// **'You are over the driving limit!'**
  String get overLimitWarning;

  /// No description provided for @todayDrinks.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Drinks'**
  String get todayDrinks;

  /// No description provided for @noDrinks.
  ///
  /// In en, this message translates to:
  /// **'No drinks today. Great!'**
  String get noDrinks;

  /// No description provided for @disclaimer.
  ///
  /// In en, this message translates to:
  /// **'WARNING: Mathematical estimate. Do not replace real breathalyzers. Never drink and drive.'**
  String get disclaimer;

  /// No description provided for @statusUnder.
  ///
  /// In en, this message translates to:
  /// **'🟢 Under limit'**
  String get statusUnder;

  /// No description provided for @statusOver.
  ///
  /// In en, this message translates to:
  /// **'🔴 Over limit'**
  String get statusOver;

  /// No description provided for @estimatedTime.
  ///
  /// In en, this message translates to:
  /// **'Estimated time:'**
  String get estimatedTime;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'BAC Trend'**
  String get historyTitle;

  /// No description provided for @drinkHistory.
  ///
  /// In en, this message translates to:
  /// **'Drink History'**
  String get drinkHistory;

  /// No description provided for @noDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noDataAvailable;

  /// No description provided for @addDrinkTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Drink'**
  String get addDrinkTitle;

  /// No description provided for @drinkName.
  ///
  /// In en, this message translates to:
  /// **'Name (e.g. Beer)'**
  String get drinkName;

  /// No description provided for @volume.
  ///
  /// In en, this message translates to:
  /// **'Volume (ml)'**
  String get volume;

  /// No description provided for @abv.
  ///
  /// In en, this message translates to:
  /// **'Alcohol (%)'**
  String get abv;

  /// No description provided for @addBtn.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addBtn;

  /// No description provided for @cancelBtn.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelBtn;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @physicalProfile.
  ///
  /// In en, this message translates to:
  /// **'Physical Profile'**
  String get physicalProfile;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get weight;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height (cm)'**
  String get height;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender (M/F)'**
  String get gender;

  /// No description provided for @legalLimit.
  ///
  /// In en, this message translates to:
  /// **'Legal Limit (g/l)'**
  String get legalLimit;

  /// No description provided for @saveBtn.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveBtn;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to SoberTrack'**
  String get welcomeTitle;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your details for an accurate calculation.'**
  String get welcomeSubtitle;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @weightLabel.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weightLabel;

  /// No description provided for @heightLabel.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get heightLabel;

  /// No description provided for @ageLabel.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get ageLabel;

  /// No description provided for @unitKg.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get unitKg;

  /// No description provided for @unitCm.
  ///
  /// In en, this message translates to:
  /// **'cm'**
  String get unitCm;

  /// No description provided for @unitYears.
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get unitYears;

  /// No description provided for @onboardingDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'I understand that the values shown are mathematical estimates and do not replace a real breathalyzer. I will not drink and drive.'**
  String get onboardingDisclaimer;

  /// No description provided for @startBtn.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get startBtn;

  /// No description provided for @settingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Edit your physical data to recalculate your BAC.'**
  String get settingsSubtitle;

  /// No description provided for @stomachStatus.
  ///
  /// In en, this message translates to:
  /// **'Stomach status'**
  String get stomachStatus;

  /// No description provided for @stomachEmpty.
  ///
  /// In en, this message translates to:
  /// **'Empty'**
  String get stomachEmpty;

  /// No description provided for @stomachNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get stomachNormal;

  /// No description provided for @stomachFull.
  ///
  /// In en, this message translates to:
  /// **'Full'**
  String get stomachFull;

  /// No description provided for @hoursSinceMeal.
  ///
  /// In en, this message translates to:
  /// **'Hours since meal'**
  String get hoursSinceMeal;

  /// No description provided for @beer.
  ///
  /// In en, this message translates to:
  /// **'Beer'**
  String get beer;

  /// No description provided for @wine.
  ///
  /// In en, this message translates to:
  /// **'Wine'**
  String get wine;

  /// No description provided for @shot.
  ///
  /// In en, this message translates to:
  /// **'Shot'**
  String get shot;

  /// No description provided for @amaro.
  ///
  /// In en, this message translates to:
  /// **'Bitter'**
  String get amaro;

  /// No description provided for @cocktail.
  ///
  /// In en, this message translates to:
  /// **'Cocktail'**
  String get cocktail;

  /// No description provided for @customDates.
  ///
  /// In en, this message translates to:
  /// **'Dates'**
  String get customDates;

  /// No description provided for @infoResponsibilityTitle.
  ///
  /// In en, this message translates to:
  /// **'Info & Responsibility'**
  String get infoResponsibilityTitle;

  /// No description provided for @bacDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'DISCLAIMER: This app provides theoretical estimates. Alcohol metabolism varies based on genetics, weight, food intake, and health. NEVER drive or make important decisions after consuming alcohol. Always use common sense and do not entrust your life to an app.'**
  String get bacDisclaimer;

  /// No description provided for @estimatedEffectsTitle.
  ///
  /// In en, this message translates to:
  /// **'Estimated effects by BAC range:'**
  String get estimatedEffectsTitle;

  /// No description provided for @bacEffect1.
  ///
  /// In en, this message translates to:
  /// **'Mild relaxation, slight euphoria. No noticeable deficits. (New drivers/professionals: fines and points deduction).'**
  String get bacEffect1;

  /// No description provided for @bacEffect2.
  ///
  /// In en, this message translates to:
  /// **'Lowered inhibitions, slowed reflexes. Driving impaired. (Standard drivers: heavy fines, license suspension. Penalties doubled in case of an accident).'**
  String get bacEffect2;

  /// No description provided for @bacEffect3.
  ///
  /// In en, this message translates to:
  /// **'Poor coordination, altered balance and vision. (Severe fines, possible imprisonment up to 6 months, license suspension 6-12 months).'**
  String get bacEffect3;

  /// No description provided for @bacEffect4.
  ///
  /// In en, this message translates to:
  /// **'Severe confusion, nausea, difficulty speaking and walking. (Maximum fines, imprisonment 6-12 months, license suspension 1-2 years, vehicle confiscation).'**
  String get bacEffect4;

  /// No description provided for @bacEffect5.
  ///
  /// In en, this message translates to:
  /// **'Severe risk of intoxication, possible loss of consciousness. (As above, with immediate license revocation. Extreme risk of coma or death).'**
  String get bacEffect5;

  /// No description provided for @over30.
  ///
  /// In en, this message translates to:
  /// **'Over 0.30'**
  String get over30;

  /// No description provided for @gotItBtn.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get gotItBtn;

  /// No description provided for @hydrationTitle.
  ///
  /// In en, this message translates to:
  /// **'Recommended Hydration'**
  String get hydrationTitle;

  /// No description provided for @hydrationAdvice.
  ///
  /// In en, this message translates to:
  /// **'Drink at least {ml} ml of water (about {glasses} glasses) to support recovery.'**
  String hydrationAdvice(int ml, int glasses);

  /// No description provided for @newDriver.
  ///
  /// In en, this message translates to:
  /// **'New Driver'**
  String get newDriver;

  /// No description provided for @newDriverDesc.
  ///
  /// In en, this message translates to:
  /// **'Sets the legal limit to 0.0 g/l (can be changed in settings)'**
  String get newDriverDesc;

  /// No description provided for @prosecco.
  ///
  /// In en, this message translates to:
  /// **'Prosecco'**
  String get prosecco;

  /// No description provided for @themeTitle.
  ///
  /// In en, this message translates to:
  /// **'App Theme'**
  String get themeTitle;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
