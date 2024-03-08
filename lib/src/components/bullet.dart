import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:garbage_game/src/bloc/game/game_bloc.dart';
import 'package:garbage_game/src/components/play_area.dart';
import 'package:garbage_game/src/game.dart';
import 'package:garbage_game/src/components/enemy.dart';
import 'package:garbage_game/src/models/bullet_type.dart';

class Bullet extends SpriteComponent
    with CollisionCallbacks, HasGameReference<GarbageGame> {
  Bullet({
    required super.size,
    required this.velocity,
    required super.position,
    BulletType? type,
  })  : type = type ?? BulletType.normal,
        super(
          sprite: type == BulletType.bounce
              ? Sprite(Flame.images.fromCache('sprites/ball.png'))
              : type == BulletType.big
                  ? Sprite(Flame.images.fromCache('sprites/shuriken.png'))
                  : Sprite(Flame.images.fromCache('sprites/kunai.png')),
          anchor: Anchor.center,
          children: [RectangleHitbox()],
          priority: 1,
        );

  final Vector2 velocity;
  final BulletType type;

  @override
  FutureOr<void> onLoad() {
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
