import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:garbage_game/src/game.dart';

class Bridge extends PositionComponent with HasGameReference<Game> {
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(game.width / 6, 0),
      Offset(0, game.height),
      paint,
    );
    canvas.drawLine(
      Offset(game.width - (game.width / 6), 0),
      Offset(game.width, game.height),
      paint,
    );
  }
}
