// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'SoberTrack';

  @override
  String get currentBac => 'BAC Attuale';

  @override
  String get soberAt => 'Sobrio alle';

  @override
  String get underLimitAt => 'Sotto il limite alle';

  @override
  String get youAreSober => 'Sei sobrio!';

  @override
  String get overLimitWarning => 'Sei oltre il limite per guidare!';

  @override
  String get todayDrinks => 'Drink di Oggi';

  @override
  String get noDrinks => 'Nessun drink oggi. Ottimo!';

  @override
  String get disclaimer =>
      'ATTENZIONE: Stima matematica. Non sostituire a etilometri reali. Non guidare.';

  @override
  String get statusUnder => '🟢 Sotto il limite';

  @override
  String get statusOver => '🔴 Oltre il limite';

  @override
  String get estimatedTime => 'Tempo stimato:';

  @override
  String get historyTitle => 'Andamento BAC';

  @override
  String get drinkHistory => 'Cronologia Drink';

  @override
  String get noDataAvailable => 'Nessun dato disponibile';

  @override
  String get addDrinkTitle => 'Aggiungi Drink';

  @override
  String get drinkName => 'Nome (es. Birra)';

  @override
  String get volume => 'Volume (ml)';

  @override
  String get abv => 'Alcol (%)';

  @override
  String get addBtn => 'Aggiungi';

  @override
  String get cancelBtn => 'Annulla';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get physicalProfile => 'Profilo Fisico';

  @override
  String get weight => 'Peso (kg)';

  @override
  String get height => 'Altezza (cm)';

  @override
  String get age => 'Età';

  @override
  String get gender => 'Sesso (M/F)';

  @override
  String get legalLimit => 'Limite Legale (g/l)';

  @override
  String get saveBtn => 'Salva';

  @override
  String get welcomeTitle => 'Benvenuto su SoberTrack';

  @override
  String get welcomeSubtitle =>
      'Inserisci i tuoi dati per un calcolo accurato.';

  @override
  String get male => 'Uomo';

  @override
  String get female => 'Donna';

  @override
  String get weightLabel => 'Peso';

  @override
  String get heightLabel => 'Altezza';

  @override
  String get ageLabel => 'Età';

  @override
  String get unitKg => 'kg';

  @override
  String get unitCm => 'cm';

  @override
  String get unitYears => 'anni';

  @override
  String get onboardingDisclaimer =>
      'Comprendo che i valori mostrati sono solo stime matematiche e non sostituiscono un etilometro reale. Non guiderò se ho bevuto.';

  @override
  String get startBtn => 'Inizia';

  @override
  String get settingsSubtitle =>
      'Modifica i tuoi dati fisici per ricalcolare il tasso alcolemico.';

  @override
  String get stomachStatus => 'Stato dello stomaco';

  @override
  String get stomachEmpty => 'Vuoto';

  @override
  String get stomachNormal => 'Normale';

  @override
  String get stomachFull => 'Pieno';

  @override
  String get hoursSinceMeal => 'Ore dall\'ultimo pasto';

  @override
  String get beer => 'Birra';

  @override
  String get wine => 'Vino';

  @override
  String get shot => 'Shot';

  @override
  String get amaro => 'Amaro';

  @override
  String get cocktail => 'Cocktail';

  @override
  String get customDates => 'Date';

  @override
  String get infoResponsibilityTitle => 'Info & Responsabilità';

  @override
  String get bacDisclaimer =>
      'DISCLAIMER: Questa app fornisce stime teoriche. Il metabolismo dell\'alcol varia in base a genetica, peso, cibo ingerito e salute. NON guidare mai e non prendere decisioni importanti dopo aver consumato alcol. Usa sempre il buon senso e non affidare la tua vita a un\'app.';

  @override
  String get estimatedEffectsTitle => 'Effetti stimati per range di BAC:';

  @override
  String get bacEffect1 =>
      'Lieve rilassamento, leggera euforia. Nessun deficit evidente. (Sanzioni per neopatentati/professionisti: multa €168-€672, decurtazione 5 punti).';

  @override
  String get bacEffect2 =>
      'Minore inibizione, riflessi rallentati. Guida compromessa. (Sanzioni: multa €543-€2170, sospensione patente 3-6 mesi, -10 punti. Pene raddoppiate in caso di incidente).';

  @override
  String get bacEffect3 =>
      'Scarsa coordinazione, alterazione dell\'equilibrio e della vista. (Sanzioni: multa €800-€3200, arresto fino a 6 mesi, sospensione patente 6-12 mesi).';

  @override
  String get bacEffect4 =>
      'Forte confusione, nausea, difficoltà a parlare e camminare. (Sanzioni: multa €1500-€6000, arresto 6-12 mesi, sospensione patente 1-2 anni, confisca del veicolo).';

  @override
  String get bacEffect5 =>
      'Rischio grave di intossicazione, possibile perdita di coscienza. (Sanzioni: come sopra, con revoca immediata della patente e confisca del mezzo. Rischio coma o morte).';

  @override
  String get over30 => 'Oltre 0.30';

  @override
  String get gotItBtn => 'Ho capito';

  @override
  String get hydrationTitle => 'Idratazione consigliata';

  @override
  String hydrationAdvice(int ml, int glasses) {
    return 'Bevi almeno $ml ml di acqua (circa $glasses bicchieri) per supportare lo smaltimento.';
  }

  @override
  String get newDriver => 'Neopatentato';

  @override
  String get newDriverDesc =>
      'Imposta il limite legale a 0.0 g/l (può essere modificato nelle impostazioni)';
}
