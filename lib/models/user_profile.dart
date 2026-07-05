class UserProfile {
  final double weight;
  final double height;
  final int age;
  final String gender;
  final bool isNewDriver;
  final bool isOnboarded;
  final bool isLoading;
  final bool use24HourFormat;

  double get legalLimit => isNewDriver ? 0.0 : 0.5;

  UserProfile({
    required this.weight,
    required this.height,
    required this.age,
    required this.gender,
    this.isNewDriver = false,
    this.isOnboarded = false,
    this.isLoading = false,
    this.use24HourFormat = true,
  });

  UserProfile copyWith({
    double? weight,
    double? height,
    int? age,
    String? gender,
    bool? isNewDriver,
    bool? isOnboarded,
    bool? isLoading,
    bool? use24HourFormat,
  }) {
    return UserProfile(
      weight: weight ?? this.weight,
      height: height ?? this.height,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      isNewDriver: isNewDriver ?? this.isNewDriver,
      isOnboarded: isOnboarded ?? this.isOnboarded,
      isLoading: isLoading ?? this.isLoading,
      use24HourFormat: use24HourFormat ?? this.use24HourFormat,
    );
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    try {
      return UserProfile(
        weight: (map['weight'] ?? 70.0).toDouble(),
        height: (map['height'] ?? 170.0).toDouble(),
        age: (map['age'] ?? 25).toInt(),
        gender: map['gender'] ?? 'M',
        isNewDriver: map['isNewDriver'] ?? false,
        isOnboarded: map['isOnboarded'] ?? false,
        isLoading: false,
        use24HourFormat: map['use24HourFormat'] ?? true,
      );
    } catch (e) {
      return UserProfile(
        weight: 70.0,
        height: 170.0,
        age: 25,
        gender: 'M',
        isNewDriver: false,
        isOnboarded: false,
        isLoading: false,
        use24HourFormat: true,
      );
    }
  }

  // Per salvare i dati sul telefono
  Map<String, dynamic> toMap() => {
    'weight': weight, 'height': height, 'age': age,
    'gender': gender, 'isNewDriver': isNewDriver, 'isOnboarded': isOnboarded,
    'use24HourFormat': use24HourFormat,
  };
}