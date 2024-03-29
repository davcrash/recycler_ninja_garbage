import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:garbage_game/src/game.dart';

class PlayArea extends RectangleComponent with HasGameReference<GarbageGame> {
  PlayArea({Color? color})
      : super(
          paint: Paint()..color = color ?? Colors.white,
          children: [RectangleHitbox()],
        );

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, game.height);
  }
}
