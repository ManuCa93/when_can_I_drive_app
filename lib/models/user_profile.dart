class UserProfile {
  final double weight;
  final double height;
  final int age;
  final String gender;
  final bool isNewDriver;
  final bool isOnboarded;

  double get legalLimit => isNewDriver ? 0.0 : 0.5;

  UserProfile({
    required this.weight,
    required this.height,
    required this.age,
    required this.gender,
    this.isNewDriver = false,
    this.isOnboarded = false,
  });

  // Per salvare i dati sul telefono
  Map<String, dynamic> toMap() => {
    'weight': weight, 'height': height, 'age': age,
    'gender': gender, 'isNewDriver': isNewDriver, 'isOnboarded': isOnboarded,
  };
}