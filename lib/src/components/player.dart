import 'dart:async' as dart_async;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:garbage_game/src/bloc/game/game_bloc.dart';
import 'package:garbage_game/src/components/enemy.dart';
import 'package:garbage_game/src/game.dart';

enum SpriteAnimationState { move, idle }

class Player extends SpriteAnimationGroupComponent
    with DragCallbacks, CollisionCallbacks, HasGameReference<GarbageGame> {
  Player({
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.center,
          children: [RectangleHitbox()],
          priority: 5,
        );

  dart_async.Timer? _moveDebounce;
  int _movePressedCount = 0;

  void _loadAllAnimations() {
    animations = {
      SpriteAnimationState.move: _spriteAnimation(
        'sprites/player/move.png',
        6,
        0.07,
      ),
      SpriteAnimationState.idle: _spriteAnimation(
        'sprites/player/idle.png',
        2,
        0.2,
      ),
    };
    current = SpriteAnimationState.idle;
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

  void moveBy(double dx) {
    if (_moveDebounce?.isActive ?? false) _moveDebounce?.cancel();
    _movePressedCount += 1;
    current = SpriteAnimationState.move;

    add(
      MoveToEffect(
        Vector2(
          (position.x + dx).clamp(width / 2, game.width - width / 2),
          position.y,
        ),
        EffectController(duration: 0.4),
        onComplete: () {
          if (_movePressedCount == 1) {
            current = SpriteAnimationState.idle;
          }
          _moveDebounce =
              dart_async.Timer(const Duration(milliseconds: 200), () {
            current = SpriteAnimationState.idle;
            _movePressedCount = 0;
          });
        },
      ),
    );
  }

  @override
  dart_async.FutureOr<void> onLoad() {
    _loadAllAnimations();
    add(RectangleHitbox(
      position: position,
      size: size,
    ));
    return super.onLoad();
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    final status = game.gameBloc.state.status;
    if (status == GameStatus.paused || status == GameStatus.gameOver) {
      return;
    }
    super.onDragUpdate(event);
    final newPosition = (position.x + event.localDelta.x);
    if (newPosition < game.width / 10 ||
        newPosition > game.width - game.width / 10) {
      return;
    }
    current = SpriteAnimationState.move;
    position.x = newPosition.clamp(width / 2, game.width - width / 2);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    current = SpriteAnimationState.idle;
    super.onDragEnd(event);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Enemy) {
      game.gameBloc.playerCollision(type: other.type);
    }
  }
}
