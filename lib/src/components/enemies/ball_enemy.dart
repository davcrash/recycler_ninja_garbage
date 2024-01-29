import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/effects.dart';
import 'package:garbage_game/src/game.dart';
import 'package:garbage_game/src/interfaces/enemy.dart';

class BallEnemy extends CircleComponent
    with CollisionCallbacks, Enemy, HasGameReference<Game> {
  BallEnemy({
    required this.velocity,
    required super.position,
    required double radius,
  }) : super(
          radius: radius,
          anchor: Anchor.center,
          paint: Paint()
            ..color = const Color(0xff1e6091)
            ..style = PaintingStyle.fill,
          children: [CircleHitbox()],
        );

  final Vector2 velocity;

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
    radius += 0.17;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
  }
}
