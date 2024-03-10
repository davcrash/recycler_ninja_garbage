import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:garbage_game/src/bloc/game/game_bloc.dart';
import 'package:garbage_game/src/components/play_area.dart';
import 'package:garbage_game/src/game.dart';
import 'package:garbage_game/src/components/enemy.dart';
import 'package:garbage_game/src/models/bullet_type.dart';

class Bullet extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameReference<GarbageGame> {
  Bullet({
    required super.size,
    required this.velocity,
    required super.position,
    BulletType? type,
  })  : type = type ?? BulletType.normal,
        super(
          anchor: Anchor.center,
          children: [RectangleHitbox()],
          priority: 1,
        );

  final Vector2 velocity;
  final BulletType type;

  void _loadAnimation() {
    switch (type) {
      case BulletType.bounce:
        animation = _spriteAnimation(
          'sprites/ball.png',
          1,
          1,
        );
      case BulletType.big:
        animation = _spriteAnimation(
          'sprites/shuriken.png',
          3,
          .06,
        );
      case BulletType.normal:
      default:
        animation = _spriteAnimation(
          'sprites/kunai.png',
          1,
          1,
        );
    }
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
        textureSize:
            type == BulletType.normal ? Vector2(12, 34) : Vector2(30, 30),
      ),
    );
  }

  @override
  FutureOr<void> onLoad() {
    _loadAnimation();
    add(RectangleHitbox(
      position: position,
      size: size,
    ));
    return super.onLoad();
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
    position += velocity * dt;
    if (position.y < 0 || position.y > game.height) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (type == BulletType.bounce) {
      if (other is PlayArea) {
        if (intersectionPoints.first.y <= 0) {
          velocity.y = -velocity.y;
        } else if (intersectionPoints.first.x <= 0) {
          velocity.x = -velocity.x;
        } else if (intersectionPoints.first.x >= game.width) {
          velocity.x = -velocity.x;
        } else if (intersectionPoints.first.y > game.height) {
          removeFromParent();
        }
      }
    } else if (type == BulletType.normal) {
      if (other is Enemy) {
        removeFromParent();
      }
    } else if (type == BulletType.big) {
      if (other is PlayArea) {
        if (intersectionPoints.first.y <= 0) {
          removeFromParent();
        }
      }
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is Enemy && type != BulletType.big) {
      removeFromParent();
    }
    super.onCollisionEnd(other);
  }
}
