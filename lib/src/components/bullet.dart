import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:garbage_game/src/components/enemies/ball_enemy.dart';
import 'package:garbage_game/src/game.dart';

class Bullet extends CircleComponent
    with CollisionCallbacks, HasGameReference<Game> {
  Bullet({
    required this.velocity,
    required super.position,
  }) : super(
          radius: 10,
          anchor: Anchor.center,
          paint: Paint()
            ..color = Colors.orange
            ..style = PaintingStyle.fill,
          children: [CircleHitbox()],
        );

  final Vector2 velocity;
  final test = 'as';

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is BallEnemy) {
      add(RemoveEffect(delay: 0));
    }
  }
}
