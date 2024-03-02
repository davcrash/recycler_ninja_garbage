part of 'score_bloc.dart';

class ScoreState extends Equatable {
  const ScoreState({
    this.maxEnemiesKilled = 0,
    this.enemiesKilled = 0,
    this.maxScore = 0,
    this.maxLvl = 0,
  });

  final int maxEnemiesKilled;
  final int enemiesKilled;
  final int maxScore;
  final int maxLvl;

  ScoreState copyWith({
    int? maxEnemiesKilled,
    int? enemiesKilled,
    int? maxScore,
    int? maxLvl,
  }) {
    return ScoreState(
      maxEnemiesKilled: maxEnemiesKilled ?? this.maxEnemiesKilled,
      enemiesKilled: enemiesKilled ?? this.enemiesKilled,
      maxScore: maxScore ?? this.maxScore,
      maxLvl: maxLvl ?? this.maxLvl,
    );
  }

  Map<String, dynamic> toJson() => {
        "maxEnemiesKilled": maxEnemiesKilled,
        "enemiesKilled": enemiesKilled,
        "maxScore": maxScore,
        "maxLvl": maxLvl,
      };

  @override
  List<Object> get props => [
        maxEnemiesKilled,
        enemiesKilled,
        maxScore,
        maxLvl,
      ];
}
