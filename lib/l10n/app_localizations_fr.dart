// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Enjoy the Night';

  @override
  String get currentBac => 'Taux actuel';

  @override
  String get soberAt => 'Sobre à';

  @override
  String get underLimitAt => 'Sous la limite à';

  @override
  String get youAreSober => 'Vous pouvez conduire !';

  @override
  String get overLimitWarning => 'Vous dépassez la limite pour conduire !';

  @override
  String get todayDrinks => 'Verres d\'aujourd\'hui';

  @override
  String get noDrinks => 'Aucun verre aujourd\'hui. Super !';

  @override
  String get disclaimer =>
      'ATTENTION : Estimation mathématique. Ne remplace pas un éthylotest. Ne conduisez pas.';

  @override
  String get statusUnder => 'Sous la limite';

  @override
  String get statusOver => 'Au-dessus de la limite';

  @override
  String get estimatedTime => 'Temps estimé :';

  @override
  String get historyTitle => 'Tendance BAC';

  @override
  String get drinkHistory => 'Historique des verres';

  @override
  String get noDataAvailable => 'Aucune donnée disponible';

  @override
  String get addDrinkTitle => 'Ajouter un verre';

  @override
  String get drinkName => 'Nom (ex: Bière)';

  @override
  String get volume => 'Volume (ml)';

  @override
  String get abv => 'Alcool (%)';

  @override
  String get addBtn => 'Ajouter';

  @override
  String get cancelBtn => 'Annuler';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get physicalProfile => 'Profil physique';

  @override
  String get weight => 'Poids (kg)';

  @override
  String get height => 'Taille (cm)';

  @override
  String get age => 'Âge';

  @override
  String get gender => 'Sexe (H/F)';

  @override
  String get legalLimit => 'Limite légale (g/l)';

  @override
  String get saveBtn => 'Enregistrer';

  @override
  String get welcomeTitle => 'Bienvenue sur Enjoy the Night';

  @override
  String get welcomeSubtitle => 'Entrez vos détails pour un calcul précis.';

  @override
  String get male => 'Homme';

  @override
  String get female => 'Femme';

  @override
  String get weightLabel => 'Poids';

  @override
  String get heightLabel => 'Taille';

  @override
  String get ageLabel => 'Âge';

  @override
  String get unitKg => 'kg';

  @override
  String get unitCm => 'cm';

  @override
  String get unitYears => 'ans';

  @override
  String get onboardingDisclaimer =>
      'Je comprends que les valeurs sont des estimations mathématiques et ne remplacent pas un vrai éthylotest. Je ne boirai pas au volant.';

  @override
  String get startBtn => 'Commencer';

  @override
  String get settingsSubtitle =>
      'Modifiez vos données pour recalculer votre taux.';

  @override
  String get stomachStatus => 'État de l\'estomac';

  @override
  String get stomachEmpty => 'Vide';

  @override
  String get stomachNormal => 'Normal';

  @override
  String get stomachFull => 'Plein';

  @override
  String get hoursSinceMeal => 'Heures depuis le repas';

  @override
  String get beer => 'Bière';

  @override
  String get wine => 'Vin';

  @override
  String get shot => 'Shot';

  @override
  String get amaro => 'Liqueur';

  @override
  String get cocktail => 'Cocktail';

  @override
  String get customDates => 'Dates';

  @override
  String get infoResponsibilityTitle => 'Info & Responsabilité';

  @override
  String get bacDisclaimer =>
      'AVERTISSEMENT : Cette application fournit des estimations théoriques. Le métabolisme varie selon plusieurs facteurs. Ne conduisez JAMAIS après avoir bu.';

  @override
  String get estimatedEffectsTitle => 'Effets estimés selon le taux :';

  @override
  String get bacEffect1 =>
      'Légère relaxation, euphorie. Pas de déficits notables.';

  @override
  String get bacEffect2 =>
      'Inhibitions réduites, réflexes ralentis. Conduite affectée. (Fortes amendes, suspension de permis).';

  @override
  String get bacEffect3 =>
      'Mauvaise coordination, équilibre altéré. (Peines sévères, suspension de permis).';

  @override
  String get bacEffect4 =>
      'Confusion sévère, nausées, difficulté à marcher. (Amendes maximales, emprisonnement).';

  @override
  String get bacEffect5 =>
      'Risque grave d\'intoxication, perte de conscience possible. (Risque de coma).';

  @override
  String get over30 => 'Plus de 0.30';

  @override
  String get gotItBtn => 'Compris';

  @override
  String get hydrationTitle => 'Hydratation Recommandée';

  @override
  String hydrationAdvice(int ml, int glasses) {
    return 'Buvez au moins $ml ml d\'eau (environ $glasses verres) pour aider la récupération.';
  }

  @override
  String get newDriver => 'Jeune Conducteur';

  @override
  String get newDriverDesc =>
      'Fixe la limite à 0.0 g/l (modifiable dans les paramètres)';

  @override
  String get prosecco => 'Prosecco';

  @override
  String get themeTitle => 'Thème de l\'application';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get glassesCount => 'Nombre de verres';

  @override
  String get manualEdit => 'Saisie manuelle';

  @override
  String get favoritesTitle => 'Favoris';

  @override
  String get savedToFavorites => 'Ajouté aux favoris';

  @override
  String get removedFromFavorites => 'Retiré des favoris';

  @override
  String get editDrinkTitle => 'Modifier le verre';

  @override
  String get limitLabel => 'Limite';

  @override
  String get calculationExplanationTitle =>
      'Comment le taux d\'alcoolémie est-il calculé ?';

  @override
  String get calculationExplanationBody =>
      'Cette application utilise la formule de Widmark modifiée pour estimer mathématiquement votre taux d\'alcool dans le sang (BAC).\n\nCE QUI AFFECTE LE CALCUL :\n• Le poids et le sexe (ils déterminent la quantité d\'eau dans votre corps).\n• Le volume et le degré d\'alcool.\n• L\'état de l\'estomac AU MOMENT de la consommation (la nourriture ralentit l\'absorption de l\'alcool).\n\nCE QUI NE L\'AFFECTE PAS (Mythes) :\n• Manger APRÈS avoir bu : l\'alcool est déjà dans le sang, la nourriture ne l\'absorbe pas et n\'aide pas le foie à l\'éliminer.\n• Boire du café, prendre une douche froide ou boire beaucoup d\'eau (l\'eau prévient la déshydratation mais ne fait pas baisser l\'alcoolémie).\n• Seul le TEMPS permet au foie de métaboliser l\'alcool (environ 0.15 g/l par heure).';

  @override
  String get timeFormatTitle => '24-hour Time';

  @override
  String get timeFormatDesc =>
      'Switch between 12-hour (AM/PM) and 24-hour time format';
}
