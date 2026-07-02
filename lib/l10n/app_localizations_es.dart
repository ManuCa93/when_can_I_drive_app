// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Enjoy the Night';

  @override
  String get currentBac => 'BAC Actual';

  @override
  String get soberAt => 'Sobrio a las';

  @override
  String get underLimitAt => 'Bajo límite a las';

  @override
  String get youAreSober => '¡Puedes conducir!';

  @override
  String get overLimitWarning => '¡Estás sobre el límite para conducir!';

  @override
  String get todayDrinks => 'Bebidas de Hoy';

  @override
  String get noDrinks => 'Sin bebidas hoy. ¡Genial!';

  @override
  String get disclaimer =>
      'ATENCIÓN: Estimación matemática. No sustituye un alcoholímetro. Nunca conduzcas si has bebido.';

  @override
  String get statusUnder => 'Bajo límite';

  @override
  String get statusOver => 'Sobre límite';

  @override
  String get estimatedTime => 'Tiempo estimado:';

  @override
  String get historyTitle => 'Tendencia BAC';

  @override
  String get drinkHistory => 'Historial de Bebidas';

  @override
  String get noDataAvailable => 'No hay datos disponibles';

  @override
  String get addDrinkTitle => 'Añadir Bebida';

  @override
  String get drinkName => 'Nombre (ej. Cerveza)';

  @override
  String get volume => 'Volumen (ml)';

  @override
  String get abv => 'Alcohol (%)';

  @override
  String get addBtn => 'Añadir';

  @override
  String get cancelBtn => 'Cancelar';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get physicalProfile => 'Perfil Físico';

  @override
  String get weight => 'Peso (kg)';

  @override
  String get height => 'Altura (cm)';

  @override
  String get age => 'Edad';

  @override
  String get gender => 'Sexo (H/M)';

  @override
  String get legalLimit => 'Límite Legal (g/l)';

  @override
  String get saveBtn => 'Guardar';

  @override
  String get welcomeTitle => 'Bienvenido a Enjoy the Night';

  @override
  String get welcomeSubtitle => 'Introduce tus datos para un cálculo preciso.';

  @override
  String get male => 'Hombre';

  @override
  String get female => 'Mujer';

  @override
  String get weightLabel => 'Peso';

  @override
  String get heightLabel => 'Altura';

  @override
  String get ageLabel => 'Edad';

  @override
  String get unitKg => 'kg';

  @override
  String get unitCm => 'cm';

  @override
  String get unitYears => 'años';

  @override
  String get onboardingDisclaimer =>
      'Entiendo que los valores mostrados son estimaciones matemáticas y no sustituyen un alcoholímetro real. No beberé y conduciré.';

  @override
  String get startBtn => 'Comenzar';

  @override
  String get settingsSubtitle =>
      'Edita tus datos físicos para recalcular tu BAC.';

  @override
  String get stomachStatus => 'Estado del estómago';

  @override
  String get stomachEmpty => 'Vacío';

  @override
  String get stomachNormal => 'Normal';

  @override
  String get stomachFull => 'Lleno';

  @override
  String get hoursSinceMeal => 'Horas desde la comida';

  @override
  String get beer => 'Cerveza';

  @override
  String get wine => 'Vino';

  @override
  String get shot => 'Chupito';

  @override
  String get amaro => 'Licor';

  @override
  String get cocktail => 'Cóctel';

  @override
  String get customDates => 'Fechas';

  @override
  String get infoResponsibilityTitle => 'Info y Responsabilidad';

  @override
  String get bacDisclaimer =>
      'AVISO: Esta app ofrece estimaciones teóricas. El metabolismo del alcohol varía según la genética, peso y salud. NUNCA conduzcas después de consumir alcohol. No confíes tu vida a una aplicación.';

  @override
  String get estimatedEffectsTitle => 'Efectos estimados por BAC:';

  @override
  String get bacEffect1 =>
      'Relajación leve, ligera euforia. Sin déficits notables.';

  @override
  String get bacEffect2 =>
      'Menos inhibiciones, reflejos lentos. Conducción afectada. (Multas graves, suspensión de carnet).';

  @override
  String get bacEffect3 =>
      'Mala coordinación, equilibrio alterado. (Penas severas, posible prisión, suspensión de carnet).';

  @override
  String get bacEffect4 =>
      'Confusión grave, náuseas, dificultad para hablar y caminar. (Multas máximas, prisión, confiscación de vehículo).';

  @override
  String get bacEffect5 =>
      'Riesgo grave de intoxicación, posible pérdida de conciencia. (Riesgo extremo de coma o muerte).';

  @override
  String get over30 => 'Más de 0.30';

  @override
  String get gotItBtn => 'Entendido';

  @override
  String get hydrationTitle => 'Hidratación Recomendada';

  @override
  String hydrationAdvice(int ml, int glasses) {
    return 'Bebe al menos $ml ml de agua (unos $glasses vasos) para ayudar a la recuperación.';
  }

  @override
  String get newDriver => 'Conductor Novel';

  @override
  String get newDriverDesc =>
      'Establece el límite a 0.0 g/l (puede cambiarse en ajustes)';

  @override
  String get prosecco => 'Prosecco';

  @override
  String get themeTitle => 'Tema de la App';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get glassesCount => 'Número de copas';

  @override
  String get manualEdit => 'Edición manual';

  @override
  String get favoritesTitle => 'Favoritos';

  @override
  String get savedToFavorites => 'Guardado en favoritos';

  @override
  String get removedFromFavorites => 'Eliminado de favoritos';

  @override
  String get editDrinkTitle => 'Editar Bebida';

  @override
  String get limitLabel => 'Límite';
}
