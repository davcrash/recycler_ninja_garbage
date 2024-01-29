import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:garbage_game/src/game.dart';

class MainCharacter extends PositionComponent
    with DragCallbacks, HasGameReference<Game> {
  MainCharacter({
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.center,
          children: [RectangleHitbox()],
        );

  final _paint = Paint()
    ..color = const Color(0xff1e6091)
    ..style = PaintingStyle.fill;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size.toSize(),
          const Radius.circular(10 / 2),
        ),
        _paint);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    final newPosition = (position.x + event.localDelta.x);
    if (newPosition < 60 || newPosition > 760) {
      return;
    }

    position.x = newPosition.clamp(width / 2, game.width - width / 2);
  }

  void moveBy(double dx) {
    add(MoveToEffect(
      Vector2(
        (position.x + dx).clamp(width / 2, game.width - width / 2),
        position.y,
      ),
      EffectController(duration: 0.1),
    ));
  }
}
