import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:garbage_game/src/components/bullet.dart';
import 'package:garbage_game/src/game.dart';

class BallEnemy extends CircleComponent
    with CollisionCallbacks, HasGameReference<Game> {
  BallEnemy({
    required this.velocity,
    required super.position,
    required double radius,
    int? lifePoints,
  })  : lifePoints = lifePoints ?? 3,
        super(
          radius: radius,
          anchor: Anchor.center,
          paint: Paint()
            ..color = Colors.red
            ..style = PaintingStyle.fill,
          children: [CircleHitbox()],
          priority: 1,
        );

  final Vector2 velocity;
  late int lifePoints;

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Bullet) {
      lifePoints -= 1;
      if (lifePoints <= 0) {
        add(RemoveEffect(delay: 0));
      }
    }
  }
}
