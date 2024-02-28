import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:garbage_game/src/bloc/game/game_bloc.dart';
import 'package:garbage_game/src/game.dart';

class Player extends PositionComponent
    with DragCallbacks, HasGameReference<GarbageGame> {
  Player({
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.center,
          children: [RectangleHitbox()],
          priority: 5,
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
      _paint,
    );
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (game.gameBloc.state.status == GameStatus.paused) {
      return;
    }
    super.onDragUpdate(event);
    final newPosition = (position.x + event.localDelta.x);
    if (newPosition < game.width / 10 ||
        newPosition > game.width - game.width / 10) {
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
