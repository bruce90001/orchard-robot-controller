class TireData {
  final int tireNumber;
  final double pressure;
  final String unit;
  final DateTime timestamp;

  TireData({
    required this.tireNumber,
    required this.pressure,
    this.unit = 'mBar',
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  bool get isNormal => pressure >= 80 && pressure <= 120;
  bool get isLow => pressure < 80;
  bool get isHigh => pressure > 120;

  TireData copyWith({
    int? tireNumber,
    double? pressure,
    String? unit,
    DateTime? timestamp,
  }) {
    return TireData(
      tireNumber: tireNumber ?? this.tireNumber,
      pressure: pressure ?? this.pressure,
      unit: unit ?? this.unit,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  String toString() => 'Tire $tireNumber: $pressure $unit';
}

class TirePressureSet {
  final List<TireData> leftTires;
  final List<TireData> rightTires;

  TirePressureSet({
    required this.leftTires,
    required this.rightTires,
  });

  factory TirePressureSet.initial() {
    return TirePressureSet(
      leftTires: List.generate(
        4,
        (index) => TireData(tireNumber: index + 1, pressure: 100.0),
      ),
      rightTires: List.generate(
        4,
        (index) => TireData(tireNumber: index + 5, pressure: 100.0),
      ),
    );
  }

  bool get hasAnyAbnormal {
    return leftTires.any((t) => !t.isNormal) || 
           rightTires.any((t) => !t.isNormal);
  }
}
