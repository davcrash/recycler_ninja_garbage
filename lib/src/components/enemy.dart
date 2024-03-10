import 'dart:async';
import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:garbage_game/src/bloc/game/game_bloc.dart';
import 'package:garbage_game/src/components/bullet.dart';
import 'package:garbage_game/src/components/play_area.dart';
import 'package:garbage_game/src/components/player.dart';
import 'package:garbage_game/src/game.dart';
import 'package:garbage_game/src/models/bullet_type.dart';
import 'package:garbage_game/src/models/enemy_type.dart';

class Enemy extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameReference<GarbageGame> {
  Enemy({
    required this.speed,
    required super.position,
    required super.size,
    EnemyType? type,
    int? lifePoints,
    int? priority,
    bool? isLineal,
  })  : type = type ?? EnemyType.normal,
        lifePoints = lifePoints ?? 2,
        isLineal = isLineal ?? false,
        super(
          anchor: Anchor.center,
          children: [RectangleHitbox()],
          priority: priority ?? 1,
        );

  final EnemyType type;
  final double speed;
  late int lifePoints;
  final bool isLineal;
  final collisionMove = 0.9;

  factory Enemy.fast({
    required double gameWidth,
    required Vector2? position,
  }) {
    return Enemy(
      type: EnemyType.fast,
      speed: 190,
      position: position,
      size: Vector2(gameWidth * 0.07, gameWidth * 0.07),
      lifePoints: 1,
    );
  }

  factory Enemy.slow({
    required double gameWidth,
    required Vector2? position,
  }) {
    return Enemy(
      type: EnemyType.slow,
      speed: 80,
      position: position,
      size: Vector2(gameWidth * 0.14, gameWidth * 0.14),
      lifePoints: 4,
    );
  }

  factory Enemy.normal({
    required double gameWidth,
    required Vector2? position,
  }) {
    return Enemy(
      speed: 130,
      position: position,
      size: Vector2(gameWidth * 0.09, gameWidth * 0.09),
    );
  }

  void _loadAnimation() {
    switch (type) {
      case EnemyType.fast:
        animation = _spriteAnimation(
          'sprites/egg_enemy.png',
          5,
          0.08,
          40.0,
        );
      case EnemyType.slow:
        animation = _spriteAnimation(
          'sprites/banana_enemy.png',
          6,
          0.1,
          50.0,
        );
      case EnemyType.normal:
      default:
        animation = _spriteAnimation(
          'sprites/apple_enemy.png',
          7,
          0.1,
          50.0,
        );
    }
  }

  SpriteAnimation _spriteAnimation(
      String name, int amount, double stepTime, double size) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache(name),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(size),
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
    if (isLineal) {
      final movementY = speed * dt;
      y += movementY;
      return;
    }

    double dx = game.player.x - x;
    double dy = game.player.y - y;

    final distance = sqrt(dx * dx + dy * dy);

    dx /= distance;
    dy /= distance;

    final movementX = dx * speed * dt;
    final movementY = dy * speed * dt;

    x += movementX;
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
    if (other is Bullet) {
      lifePoints -= other.type == BulletType.bounce ? 2 : 1;
      if (lifePoints <= 0) {
        removeFromParent();
        game.gameBloc.killEnemy(byBullet: true, type: type);
      }
    } else if (other is Player) {
      removeFromParent();
      game.gameBloc.killEnemy(type: type);
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    final status = game.gameBloc.state.status;
    if (status == GameStatus.paused || status == GameStatus.gameOver) {
      return;
    }
    super.onCollision(intersectionPoints, other);
    if (other is Enemy) {
      if (other.position.y < position.y) {
        final positionDiff = other.position.y - position.y;
        if (positionDiff > 2 && positionDiff < -2) {
          position.y = position.y + collisionMove;
        }
      }
      if (other.position.x > position.x &&
          position.x < game.width / 2 &&
          position.x > game.width / 10) {
        position.x = position.x - collisionMove;
      }
      if (other.position.x < position.x &&
          position.x > game.width / 2 &&
          position.x < game.width - game.width / 10) {
        position.x = position.x + collisionMove;
      }
    } else if (other is PlayArea) {
      if (intersectionPoints.first.x <= game.width / 10) {
        position.x += collisionMove;
      } else if (intersectionPoints.first.x >= game.width - game.width / 10) {
        position.x -= collisionMove;
      }
    }
  }
}
