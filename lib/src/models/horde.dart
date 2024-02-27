import 'package:garbage_game/src/models/enemy_type.dart';

class Horde {
  Map<EnemyType, int> enemies;

  Horde({required this.enemies});

  Horde copyWith({
    Map<EnemyType, int>? enemies,
  }) =>
      Horde(
        enemies: enemies ?? this.enemies,
      );
}
