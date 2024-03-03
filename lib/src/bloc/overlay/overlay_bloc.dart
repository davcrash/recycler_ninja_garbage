import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garbage_game/src/models/power_up_type.dart';

part 'overlay_state.dart';

class OverlayBloc extends Cubit<OverlayState> {
  OverlayBloc() : super(OverlayHidden());

  void hide() {
    emit(OverlayHidden());
  }

  void show({
    required OverlayType type,
    PowerUpType? powerUpType,
  }) {
    emit(
      OverlayShowed(
        type: type,
        hasBackdrop: type != OverlayType.caughtPower,
        powerUpType: powerUpType,
      ),
    );
  }
}
