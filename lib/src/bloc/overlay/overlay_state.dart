part of 'overlay_bloc.dart';

enum OverlayType { paused, wonLevel, gameOver, caughtPower }

sealed class OverlayState extends Equatable {
  const OverlayState();

  @override
  List<Object> get props => [];
}

final class OverlayHidden extends OverlayState {}

final class OverlayShowed extends OverlayState {
  final OverlayType type;
  final bool hasBackdrop;
  final PowerUpType? powerUpType;

  const OverlayShowed({
    required this.type,
    required this.hasBackdrop,
    this.powerUpType,
  });

  @override
  List<Object> get props => [
        type,
        hasBackdrop,
      ];
}
