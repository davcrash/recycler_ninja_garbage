import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:garbage_game/src/components/enemy.dart';

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

  Future<void> addEnemies() async {
    const int difficulty = 1;

    final minWidth = width / 6;
    final maxWidth = width - (width / 6);

    final double sizeFactor = width * (0.04 + (0.01 * difficulty));
    final maxEnemies = maxWidth ~/ sizeFactor;
    final numEnemies = rand.nextInt(maxEnemies);

    const int speedFactor = 150 - (10 * difficulty);

    final List<Enemy> enemies = [];
    final newRand =
        minWidth + rand.nextInt(maxWidth.toInt() - minWidth.toInt() + 1);

    double lastMinorXPosition = newRand;
    double lastMajorXPosition = newRand;

    for (int i = 0; i < numEnemies; i++) {
      final newMinorXPosition =
          lastMinorXPosition - (i > 0 ? sizeFactor * 1.4 : 0);
      final newMajorXPosition =
          lastMajorXPosition + (i > 0 ? sizeFactor * 1.4 : 0);

      if (newMinorXPosition > minWidth) {
        lastMinorXPosition = newMinorXPosition;
        enemies.add(
          Enemy.fast(
            gameWidth: width,
            position: Vector2(newMajorXPosition, -100),
          ),
        );
      } else if (newMajorXPosition < maxWidth) {
        lastMajorXPosition = newMajorXPosition;
        enemies.add(
          Enemy.slow(
            gameWidth: width,
            position: Vector2(newMajorXPosition, -100),
          ),
        );
      }
    }

    for (var enemy in enemies) {
      world.add(enemy);
    }
  }
}
