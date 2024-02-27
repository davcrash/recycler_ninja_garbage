part of 'game_bloc.dart';

enum GameStatus { paused, playing, gameOver }

class GameState extends Equatable {
  const GameState({
    this.status = GameStatus.playing,
  });

  final GameStatus status;

  GameState copyWith({
    GameStatus? status,
  }) {
    return GameState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}
