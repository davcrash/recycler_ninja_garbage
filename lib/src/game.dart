import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:garbage_game/src/components/enemies/ball_enemy.dart';

import 'components/bridge.dart';
import 'components/main_character.dart';
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

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());
    world.add(
      Bridge(),
    );

    world.add(
      MainCharacter(
        size: Vector2(width * 0.08, width * 0.1),
        position: Vector2(width / 2, height * 0.86),
      ),
    );

    world.add(
      BallEnemy(
        radius: 0,
        position: Vector2(width / 2, -100),
        velocity: Vector2(0, height * 0.2).normalized()..scale(height / 4),
      ),
    );

    //debugMode = true;
  }
}
