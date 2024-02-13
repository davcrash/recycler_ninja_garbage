import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:garbage_game/src/game.dart';
import 'package:garbage_game/src/interfaces/enemy.dart';

class Bullet extends PositionComponent
    with CollisionCallbacks, HasGameReference<Game> {
  Bullet({
    required super.size,
    required this.velocity,
    required super.position,
  }) : super(anchor: Anchor.center, children: [RectangleHitbox()], priority: 1);

  final Vector2 velocity;
  final _paint = Paint()
    ..color = Colors.orange
    ..style = PaintingStyle.fill;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size.toSize(),
        const Radius.circular(0),
      ),
      _paint,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
    if (position.y < 0) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Enemy) {
      removeFromParent();
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is Enemy) {
      removeFromParent();
    }
    super.onCollisionEnd(other);
  }
}
