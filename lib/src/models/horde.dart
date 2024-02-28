import 'package:garbage_game/src/models/enemy_type.dart';

class Horde {
  final Map<EnemyType, int> enemies;

  const Horde({required this.enemies});

  Horde copyWith({
    Map<EnemyType, int>? enemies,
  }) =>
      Horde(
        enemies: enemies ?? this.enemies,
      );
}
