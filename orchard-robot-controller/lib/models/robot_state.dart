class RobotState {
  final Position position;
  final Orientation orientation;
  final int battery;
  final String mode;
  final bool isNavigating;
  final bool isPaused;

  RobotState({
    required this.position,
    required this.orientation,
    required this.battery,
    required this.mode,
    this.isNavigating = false,
    this.isPaused = false,
  });

  factory RobotState.initial() {
    return RobotState(
      position: Position(x: 0, y: 0, z: 0),
      orientation: Orientation(x: 0, y: 0, z: 0, w: 1),
      battery: 100,
      mode: 'manual',
    );
  }

  RobotState copyWith({
    Position? position,
    Orientation? orientation,
    int? battery,
    String? mode,
    bool? isNavigating,
    bool? isPaused,
  }) {
    return RobotState(
      position: position ?? this.position,
      orientation: orientation ?? this.orientation,
      battery: battery ?? this.battery,
      mode: mode ?? this.mode,
      isNavigating: isNavigating ?? this.isNavigating,
      isPaused: isPaused ?? this.isPaused,
    );
  }
}

class Position {
  final double x;
  final double y;
  final double z;

  Position({required this.x, required this.y, required this.z});

  @override
  String toString() => 'Position(x: $x, y: $y, z: $z)';
}

class Orientation {
  final double x;
  final double y;
  final double z;
  final double w;

  Orientation({
    required this.x,
    required this.y,
    required this.z,
    required this.w,
  });

  @override
  String toString() => 'Orientation(x: $x, y: $y, z: $z, w: $w)';
}
