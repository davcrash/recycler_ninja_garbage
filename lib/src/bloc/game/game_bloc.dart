import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garbage_game/src/const/levels.dart';
import 'package:garbage_game/src/models/enemy_type.dart';
import 'package:garbage_game/src/models/horde.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Cubit<GameState> {
  GameBloc() : super(GameState(currentLevel: levels[0]));

  void pause() {
    if (state.status == GameStatus.playing) {
      emit(state.copyWith(status: GameStatus.paused));
      return;
    }
    emit(state.copyWith(status: GameStatus.playing));
  }

  void wonLevel() {
    final newLevelNum = state.currentLevelNumber + 1;
    if (newLevelNum >= levels.length) {
      //TODO: game finish
      return;
    }
    emit(
      state.copyWith(
        currentLevelNumber: newLevelNum,
        currentLevel: levels[newLevelNum],
        status: GameStatus.wonLevel,
      ),
    );
  }

  void killEnemy({
    bool byBullet = false,
    required EnemyType type,
  }) {
    emit(
      state.copyWith(
        killedEnemies: state.killedEnemies + 1,
        score: state.score + _getScoreByType(byBullet, type),
      ),
    );
  }

  int _getScoreByType(bool byBullet, EnemyType type) {
    if (!byBullet) return 0;
    switch (type) {
      case EnemyType.fast:
        return 50;
      case EnemyType.slow:
        return 150;
      case EnemyType.normal:
      default:
        return 100;
    }
  }
}
