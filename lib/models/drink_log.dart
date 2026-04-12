enum StomachState { empty, normal, full }

class DrinkLog {
  final String id;
  final String name;
  final double volume;
  final double abv;
  final DateTime timestamp;
  final StomachState stomachState;
  final double hoursSinceMeal;

  DrinkLog({
    required this.id,
    required this.name,
    required this.volume,
    required this.abv,
    required this.timestamp,
    required this.stomachState,
    required this.hoursSinceMeal,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'volume': volume,
      'abv': abv,
      'timestamp': timestamp.toIso8601String(),
      'stomachState': stomachState.index,
      'hoursSinceMeal': hoursSinceMeal,
    };
  }

  factory DrinkLog.fromMap(Map<String, dynamic> map) {
    return DrinkLog(
      id: map['id'],
      name: map['name'],
      volume: map['volume'],
      abv: map['abv'],
      timestamp: DateTime.parse(map['timestamp']),
      stomachState: StomachState.values[map['stomachState']],
      hoursSinceMeal: map['hoursSinceMeal'],
    );
  }
}