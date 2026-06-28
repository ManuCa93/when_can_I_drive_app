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
    try {
      return DrinkLog(
        id: map['id'] ?? '',
        name: map['name'] ?? 'Sconosciuto',
        volume: (map['volume'] ?? 0.0).toDouble(),
        abv: (map['abv'] ?? 0.0).toDouble(),
        timestamp: map['timestamp'] != null ? DateTime.parse(map['timestamp']) : DateTime.now(),
        stomachState: map['stomachState'] != null && map['stomachState'] >= 0 && map['stomachState'] < StomachState.values.length
            ? StomachState.values[map['stomachState']]
            : StomachState.normal,
        hoursSinceMeal: (map['hoursSinceMeal'] ?? 0.0).toDouble(),
      );
    } catch (e) {
      // In caso di errore parsing (es. data invalida), usa default sicuri
      return DrinkLog(
        id: map['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: 'Sconosciuto',
        volume: 0.0,
        abv: 0.0,
        timestamp: DateTime.now(),
        stomachState: StomachState.normal,
        hoursSinceMeal: 0.0,
      );
    }
  }
}