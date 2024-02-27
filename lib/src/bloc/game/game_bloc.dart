import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Cubit<GameState> {
  GameBloc() : super(const GameState());

  void pause() {
    if (state.status == GameStatus.paused) {
      emit(state.copyWith(status: GameStatus.playing));
      return;
    }
    emit(state.copyWith(status: GameStatus.paused));
  }
}
