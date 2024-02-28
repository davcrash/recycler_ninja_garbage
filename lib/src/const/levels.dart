import 'package:garbage_game/src/models/enemy_type.dart';
import 'package:garbage_game/src/models/horde.dart';

final List<Horde> levels = [
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
      EnemyType.fast: 30,
      EnemyType.normal: 20,
      EnemyType.slow: 3,
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
