import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:garbage_game/src/game.dart';

class PlayerMoveArea extends PositionComponent with HasGameReference<Game> {
  PlayerMoveArea({
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.center,
          children: [RectangleHitbox()],
        );

  final _paint = Paint()
    ..color = Colors.transparent
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
}
