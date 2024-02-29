part of 'power_up_bloc.dart';

class PowerUpState extends Equatable {
  const PowerUpState({
    this.powersLevel = const {},
    this.latestCaughtPower,
  });

  final Map<PowerUpType, int> powersLevel;
  final PowerUpType? latestCaughtPower;

  PowerUpState copyWith({
    Map<PowerUpType, int>? powersLevel,
    PowerUpType? latestCaughtPower,
  }) {
    return PowerUpState(
      powersLevel: powersLevel ?? this.powersLevel,
      latestCaughtPower: latestCaughtPower ?? this.latestCaughtPower,
    );
  }

  @override
  List<Object> get props => [
        powersLevel,
      ];
}
