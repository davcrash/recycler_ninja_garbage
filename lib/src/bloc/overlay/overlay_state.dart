part of 'overlay_bloc.dart';

enum OverlayType { paused, wonLevel, gameOver, caughtPower, world }

sealed class OverlayState extends Equatable {
  const OverlayState();

  @override
  List<Object> get props => [];
}

final class OverlayHidden extends OverlayState {}

final class OverlayShowed extends OverlayState {
  final OverlayType type;
  final PowerUpType? powerUpType;

  const OverlayShowed({
    required this.type,
    this.powerUpType,
  });

  @override
  List<Object> get props => [
        type,
      ];
}
