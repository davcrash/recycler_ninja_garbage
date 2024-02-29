import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:garbage_game/src/bloc/game/game_bloc.dart';
import 'package:garbage_game/src/components/bullet.dart';
import 'package:garbage_game/src/components/play_area.dart';
import 'package:garbage_game/src/components/player.dart';
import 'package:garbage_game/src/game.dart';
import 'package:garbage_game/src/models/enemy_type.dart';

class Enemy extends PositionComponent
    with CollisionCallbacks, HasGameReference<GarbageGame> {
  Enemy({
    required this.speed,
    required super.position,
    required super.size,
    EnemyType? type,
    Color? color,
    int? lifePoints,
    int? priority,
    bool? isLineal,
  })  : type = type ?? EnemyType.normal,
        lifePoints = lifePoints ?? 2,
        color = color ?? Colors.red,
        isLineal = isLineal ?? false,
        super(
          anchor: Anchor.center,
          children: [RectangleHitbox()],
          priority: priority ?? 1,
        );

  final EnemyType type;
  final double speed;
  late int lifePoints;
  final Color color;
  final bool isLineal;
  final collisionMove = 0.7;

  factory Enemy.fast({
    required double gameWidth,
    required Vector2? position,
  }) {
    return Enemy(
      type: EnemyType.fast,
      speed: 190,
      position: position,
      size: Vector2(gameWidth * 0.05, gameWidth * 0.05),
      color: Colors.amber,
      lifePoints: 1,
    );
  }

  factory Enemy.slow({
    required double gameWidth,
    required Vector2? position,
  }) {
    return Enemy(
      type: EnemyType.slow,
      speed: 80,
      position: position,
      size: Vector2(gameWidth * 0.12, gameWidth * 0.12),
      color: Colors.orangeAccent,
      lifePoints: 4,
    );
  }

  factory Enemy.normal({
    required double gameWidth,
    required Vector2? position,
  }) {
    return Enemy(
      speed: 155,
      position: position,
      size: Vector2(gameWidth * 0.07, gameWidth * 0.07),
    );
  }

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
  void update(double dt) {
    final status = game.gameBloc.state.status;
    if (status == GameStatus.paused || status == GameStatus.gameOver) {
      return;
    }
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
        game.gameBloc.killEnemy(byBullet: true, type: type);
        removeFromParent();
      }
    } else if (other is Player) {
      game.gameBloc.killEnemy(type: type);
      add(RemoveEffect(delay: 0.2));
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    final status = game.gameBloc.state.status;
    if (status == GameStatus.paused || status == GameStatus.gameOver) {
      return;
    }
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
