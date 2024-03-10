import 'package:garbage_game/src/models/enemy_type.dart';
import 'package:garbage_game/src/models/horde.dart';

final List<Horde> levels = [
  for (var i = 0; i < 1; i++) ...levelsModel,
];
final List<Horde> levelsModel = [
  const Horde(
    enemies: {
      EnemyType.normal: 10,
    },
  ),
  const Horde(
    enemies: {
      EnemyType.fast: 30,
    },
  ),
  const Horde(
    enemies: {
      EnemyType.fast: 30,
      EnemyType.normal: 20,
    },
  ),
  const Horde(
    enemies: {
      EnemyType.fast: 70,
    },
  ),
  const Horde(
    enemies: {
      EnemyType.normal: 70,
    },
  ),
  const Horde(
    enemies: {
      EnemyType.fast: 30,
      EnemyType.normal: 20,
      EnemyType.slow: 3,
    },
  ),
  const Horde(
    enemies: {
      EnemyType.slow: 20,
    },
  ),
  const Horde(
    enemies: {
      EnemyType.slow: 40,
      EnemyType.normal: 100,
    },
  ),
  const Horde(
    enemies: {
      EnemyType.fast: 100,
      EnemyType.slow: 10,
    },
  ),
  const Horde(
    enemies: {
      EnemyType.fast: 100,
      EnemyType.normal: 20,
      EnemyType.slow: 20,
    },
  ),
  const Horde(
    enemies: {
      EnemyType.fast: 100,
      EnemyType.normal: 70,
      EnemyType.slow: 20,
    },
  ),
];
