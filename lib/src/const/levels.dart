import 'package:garbage_game/src/models/enemy_type.dart';
import 'package:garbage_game/src/models/horde.dart';

final List<Horde> levels = [
  Horde(
    enemies: {
      EnemyType.slow: 10,
      EnemyType.normal: 10,
      EnemyType.fast: 10,
    },
  ),
];
