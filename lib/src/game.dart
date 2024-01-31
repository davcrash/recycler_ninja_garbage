import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:garbage_game/src/components/enemies/ball_enemy.dart';

import 'components/bullet.dart';
import 'components/player.dart';
import 'components/play_area.dart';

class Game extends FlameGame
    with HasCollisionDetection, KeyboardEvents, TapDetector {
  Game()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: 820.0,
            height: 1600.0,
          ),
        );

  double get width => size.x;
  double get height => size.y;
  final rand = math.Random();

  late Player player;
  late final Timer _shootTimer = Timer(
    0.7,
    onTick: () => shoot(),
    repeat: true,
  );

  late final Timer _enemyTimer = Timer(
    1,
    onTick: () => addEnemies(),
    repeat: true,
  );

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());

    player = Player(
      size: Vector2(width * 0.08, width * 0.1),
      position: Vector2(width / 2, height * 0.86),
    );
    world.add(player);

    _shootTimer.start();
    _enemyTimer.start();

    //debugMode = true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _shootTimer.update(dt);
    _enemyTimer.update(dt);
  }

  void shoot() {
    world.add(
      Bullet(
        position: player.position,
        velocity: Vector2(0, -1).normalized()..scale(height),
      ),
    );
  }

  addEnemies() async {
    final min = width / 6;
    final max = width - (width / 6);
    final newRand = min + rand.nextInt(max.toInt() - min.toInt() + 1);
    world.add(
      BallEnemy(
        radius: 30,
        position: Vector2(newRand, -100),
        velocity: Vector2(0, 1).normalized()..scale(height / 6),
      ),
    );

    /*  world.add(
      BallEnemy(
        radius: 100,
        position: Vector2(width / 2, -200),
        velocity: Vector2(0, height * 0.4).normalized()..scale(height / 30),
      ),
    ); */
  }
}
