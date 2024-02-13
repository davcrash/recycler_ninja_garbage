import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:garbage_game/src/components/bullet.dart';
import 'package:garbage_game/src/game.dart';

class Enemy extends PositionComponent
    with CollisionCallbacks, HasGameReference<Game> {
  Enemy({
    required this.velocity,
    required super.position,
    required super.size,
    int? lifePoints,
  })  : lifePoints = lifePoints ?? 2,
        super(
          anchor: Anchor.center,
          children: [],
        );

  final _paint = Paint()
    ..color = Colors.red
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
  void onMount() {
    super.onMount();
    final shape = RectangleHitbox(
      anchor: Anchor.center,
      size: size,
      isSolid: true,
    );
    add(shape);
  }

  final Vector2 velocity;
  late int lifePoints;

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
    if (position.y > game.height) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Bullet) {
      lifePoints -= 1;
      if (lifePoints <= 0) {
        removeFromParent();
      }
    }
  }
}
