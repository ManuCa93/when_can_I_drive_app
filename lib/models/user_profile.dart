class UserProfile {
  final double weight;
  final double height;
  final int age;
  final String gender;
  final double legalLimit;
  final bool isOnboarded;

  UserProfile({
    required this.weight,
    required this.height,
    required this.age,
    required this.gender,
    this.legalLimit = 0.5,
    this.isOnboarded = false,
  });

  // Per salvare i dati sul telefono
  Map<String, dynamic> toMap() => {
    'weight': weight, 'height': height, 'age': age,
    'gender': gender, 'legalLimit': legalLimit, 'isOnboarded': isOnboarded,
  };
}