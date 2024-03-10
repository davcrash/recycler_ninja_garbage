part of 'game_bloc.dart';

enum GameStatus { paused, playing, wonLevel, gameOver, restarting }

class GameState extends Equatable {
  const GameState({
    this.status = GameStatus.playing,
    this.currentLevel = const Horde(enemies: {}),
    this.currentLevelNumber = 0,
    this.killedEnemies = 0,
    this.score = 0,
    this.playerLifePoints = 30,
    this.speedFactor = 1,
  });

  final GameStatus status;
  final Horde currentLevel;
  final int currentLevelNumber;
  final int killedEnemies;
  final int score;
  final int playerLifePoints;
  final int speedFactor;

  GameState copyWith({
    GameStatus? status,
    Horde? currentLevel,
    int? currentLevelNumber,
    int? killedEnemies,
    int? score,
    int? playerLifePoints,
    int? speedFactor,
  }) {
    return GameState(
      status: status ?? this.status,
      currentLevel: currentLevel ?? this.currentLevel,
      currentLevelNumber: currentLevelNumber ?? this.currentLevelNumber,
      killedEnemies: killedEnemies ?? this.killedEnemies,
      score: score ?? this.score,
      playerLifePoints: playerLifePoints ?? this.playerLifePoints,
      speedFactor: speedFactor ?? this.speedFactor,
    );
  }

  @override
  List<Object> get props => [
        status,
        currentLevel,
        currentLevelNumber,
        killedEnemies,
        score,
        playerLifePoints,
        speedFactor,
      ];
}
