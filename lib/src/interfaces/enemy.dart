import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:garbage_game/src/components/bullet.dart';
import 'package:garbage_game/src/components/play_area.dart';
import 'package:garbage_game/src/components/player.dart';
import 'package:garbage_game/src/components/player_move_area.dart';
import 'package:garbage_game/src/game.dart';

class Enemy extends PositionComponent
    with CollisionCallbacks, HasGameReference<Game> {
  Enemy({
    required this.speed,
    required super.position,
    required super.size,
    Color? color,
    int? lifePoints,
    int? priority,
    bool? isLineal,
  })  : lifePoints = lifePoints ?? 2,
        color = color ?? Colors.red,
        isLineal = isLineal ?? false,
        super(
          anchor: Anchor.center,
          children: [],
          priority: priority ?? 1,
        );
  final double speed;
  late int lifePoints;
  late final RectangleHitbox hitbox;
  final Color color;
  final bool isLineal;
  final collisionMove = 0.7;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size.toSize(),
        const Radius.circular(0),
      ),
      paint,
    );
  }

  @override
  void onMount() {
    super.onMount();
    hitbox = RectangleHitbox(
      size: size,
      isSolid: true,
    );
    add(hitbox);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isLineal) {
      final movementY = speed * dt;
      y += movementY;
      return;
    }

    double dx = game.player.x - x;
    double dy = game.player.y - y;

    final distance = sqrt(dx * dx + dy * dy);

    dx /= distance;
    dy /= distance;

    final movementX = dx * speed * dt;
    final movementY = dy * speed * dt;

    x += movementX;
    y += movementY;

    if (position.y > game.height) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Bullet) {
      lifePoints -= 1;
      if (lifePoints <= 0) {
        removeFromParent();
      }
    } else if (other is PlayerMoveArea || other is Player) {
      add(RemoveEffect(delay: 0.2));
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Enemy) {
      if (other.position.y < position.y) {
        final positionDiff = other.position.y - position.y;
        if (positionDiff > 2 && positionDiff < -2) {
          position.y = position.y + collisionMove;
        }
      }
      if (other.position.x > position.x &&
          position.x < game.width / 2 &&
          position.x > game.width / 10) {
        position.x = position.x - collisionMove;
      }
      if (other.position.x < position.x &&
          position.x > game.width / 2 &&
          position.x < game.width - game.width / 10) {
        position.x = position.x + collisionMove;
      }
    } else if (other is PlayArea) {
      if (intersectionPoints.first.x <= game.width / 10) {
        position.x += collisionMove;
      } else if (intersectionPoints.first.x >= game.width - game.width / 10) {
        position.x -= collisionMove;
      }
    }
  }
}
