enum EnemyStatus {
  moving,
  readyForDead,
}

mixin class Enemy {
  late double lifePoints;
  late EnemyStatus status;

  void impact() {
    lifePoints -= 1;
    if (lifePoints <= 0) {
      status = EnemyStatus.readyForDead;
    }
  }
}
