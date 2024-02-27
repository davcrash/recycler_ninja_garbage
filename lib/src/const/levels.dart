import 'package:garbage_game/src/models/enemy_type.dart';
import 'package:garbage_game/src/models/horde.dart';

final List<Horde> levels = [
  Horde(
    enemies: {
      EnemyType.normal: 10,
    },
  ),
  Horde(
    enemies: {
      EnemyType.fast: 30,
    },
  ),
  Horde(
    enemies: {
      EnemyType.fast: 30,
      EnemyType.normal: 20,
    },
  ),
  Horde(
    enemies: {
      EnemyType.fast: 30,
      EnemyType.normal: 20,
      EnemyType.slow: 3,
    },
  ),
];
