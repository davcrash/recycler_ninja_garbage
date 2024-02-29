import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:garbage_game/src/bloc/game/game_bloc.dart';
import 'package:garbage_game/src/game.dart';
import 'package:garbage_game/src/models/power_up_type.dart';

class PowerUp extends PositionComponent
    with CollisionCallbacks, HasGameReference<GarbageGame> {
  PowerUp({
    required this.speed,
    required super.position,
    required super.size,
    PowerUpType? type,
    Color? color,
    int? priority,
  })  : type = type ?? PowerUpType.heal,
        color = color ?? Colors.blue,
        super(
          anchor: Anchor.center,
          children: [RectangleHitbox()],
          priority: priority ?? 6,
        );

  final PowerUpType type;
  final double speed;
  final Color color;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size.toSize(),
        const Radius.circular(500),
      ),
      paint,
    );
  }

  @override
  void update(double dt) {
    final status = game.gameBloc.state.status;
    if (status == GameStatus.paused ||
        status == GameStatus.gameOver ||
        status == GameStatus.wonLevel) {
      return;
    }
    super.update(dt);
    final movementY = speed * dt;
    y += movementY;

    if (position.y > game.height) {
      removeFromParent();
    }
  }
}
