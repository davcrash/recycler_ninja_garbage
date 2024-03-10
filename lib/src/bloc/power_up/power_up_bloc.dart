import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garbage_game/src/models/power_up_type.dart';

part 'power_up_state.dart';

class PowerUpBloc extends Cubit<PowerUpState> {
  PowerUpBloc() : super(const PowerUpState());

  void catchAPower({
    required PowerUpType type,
  }) {
    emit(
      state.copyWith(
        latestCaughtPower: type,
        powersLevel: {
          ...state.powersLevel,
          type: (state.powersLevel[type] ?? 0) + 1,
        },
      ),
    );
  }

  void reset() {
    emit(const PowerUpState());
  }
}
