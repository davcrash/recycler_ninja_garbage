import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:garbage_game/src/bloc/audio/audio_bloc.dart';
import 'package:garbage_game/src/bloc/game/game_bloc.dart';
import 'package:garbage_game/src/bloc/overlay/overlay_bloc.dart';
import 'package:garbage_game/src/colors.dart' as colors;
import 'package:garbage_game/src/components/player.dart';
import 'package:garbage_game/src/game.dart';
import 'package:garbage_game/src/models/power_up_type.dart';

class PowerUp extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameReference<GarbageGame> {
  PowerUp({
    required this.speed,
    required super.position,
    required super.size,
    PowerUpType? type,
    Color? color,
    int? priority,
  })  : type = type ?? PowerUpType.heal,
        color = color ?? colors.blue,
        super(
          anchor: Anchor.center,
          children: [RectangleHitbox()],
          priority: priority ?? 6,
        );

  final PowerUpType type;
  final double speed;
  final Color color;

  @override
  FutureOr<void> onLoad() {
    animation = _spriteAnimation(
      'sprites/powerup.png',
      5,
      0.07,
    );
    return super.onLoad();
  }

  SpriteAnimation _spriteAnimation(
    String name,
    int amount,
    double stepTime,
  ) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache(name),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(50),
      ),
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

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Player) {
      add(
        ScaleEffect.to(
          Vector2.all(0.6),
          EffectController(duration: 0.2),
        ),
      );
      add(RemoveEffect(delay: 0.2));
      game.overlayBloc.show(type: OverlayType.caughtPower, powerUpType: type);
      game.powerUpBloc.catchAPower(type: type);

      if (game.audioBloc.state is AudioSound) {
        if (type == PowerUpType.nuclearBomb) {
          FlameAudio.play('bomb.mp3', volume: 3);
        }
        if (type == PowerUpType.heal) {
          FlameAudio.play('heal.mp3', volume: 1);
        }
      }
    }
  }
}
