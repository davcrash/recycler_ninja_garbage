import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:garbage_game/src/components/player_move_area.dart';
import 'package:garbage_game/src/interfaces/enemy.dart';

import 'components/bullet.dart';
import 'components/player.dart';
import 'components/play_area.dart';

//TODO change name of Game
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
    0.2,
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

    final playerHeight = width * 0.1;

    world.add(PlayArea());
    /* world.add(
      PlayerMoveArea(
        size: Vector2(width, playerHeight),
        position: Vector2(width / 2, height * 0.86),
      ),
    ); */

    player = Player(
      size: Vector2(width * 0.08, playerHeight),
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
    /* world.add(
      Bullet(
        size: Vector2(width * 0.02, width * 0.02),
        position: player.position,
        velocity: Vector2(0, -1).normalized()..scale(height),
      ),
    ); */
  }

  addEnemies() async {
    final min = width / 6;
    final max = width - (width / 6);
    final newRand = min + rand.nextInt(max.toInt() - min.toInt() + 1);
    final newRand2 = min + rand.nextInt(max.toInt() - min.toInt() + 1);
    world.add(
      Enemy(
        speed: 150,
        position: Vector2(newRand, -100),
        size: Vector2(width * 0.04, width * 0.04),
        color: Colors.green,
        isLineal: false,
      ),
    );
    world.add(
      Enemy(
        speed: 100,
        position: Vector2(newRand, -100),
        size: Vector2(width * 0.08, width * 0.08),
      ),
    );
    world.add(
      Enemy(
        speed: 50,
        position: Vector2(newRand2, -100),
        size: Vector2(width * 0.13, width * 0.13),
        color: Colors.orange,
        lifePoints: 5,
      ),
    );
  }
}
