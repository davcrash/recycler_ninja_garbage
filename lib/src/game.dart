import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:garbage_game/src/bloc/game/game_bloc.dart';
import 'package:garbage_game/src/components/enemy.dart';
import 'package:garbage_game/src/const/levels.dart';
import 'package:garbage_game/src/models/enemy_type.dart';
import 'package:garbage_game/src/models/horde.dart';

import 'components/bullet.dart';
import 'components/player.dart';
import 'components/play_area.dart';

class GarbageGame extends FlameGame
    with HasCollisionDetection, KeyboardEvents, TapDetector {
  GarbageGame({
    required this.gameBloc,
  }) : super(
          camera: CameraComponent.withFixedResolution(
            width: 820.0,
            height: 1600.0,
          ),
        );

  double get width => size.x;
  double get height => size.y;
  final rand = math.Random();
  final GameBloc gameBloc;
  late Player player;

  late final Timer _shootTimer = Timer(
    0.2,
    onTick: () => shoot(),
    repeat: true,
  );

  late final Timer _enemyTimer = Timer(
    1,
    onTick: () => addEnemies(),
    repeat: true,
  );
  final currentLevel = levels[0];
  final currentLevelPrintedEnemies = Horde(enemies: {
    EnemyType.slow: 0,
    EnemyType.normal: 0,
    EnemyType.fast: 0,
  });
  bool isPrintedCompleted = false;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    final playerHeight = width * 0.1;

    await add(
      FlameBlocListener<GameBloc, GameState>(
        bloc: gameBloc,
        onNewState: (state) {
          if (state.status == GameStatus.paused) {
            overlays.add(state.status.name);
            _enemyTimer.pause();
            _shootTimer.pause();
          } else if (state.status == GameStatus.playing) {
            overlays.remove(GameStatus.paused.name);
            _enemyTimer.resume();
            _shootTimer.resume();
          }
        },
      ),
    );

    world.add(PlayArea());
    /* world.add(
      PlayerMoveArea(
        size: Vector2(width, playerHeight),
        position: Vector2(width / 2, height * 0.86),
      ),
    ); */

    player = Player(
      size: Vector2(width * 0.08, playerHeight),
      position: Vector2(width / 2, height * 0.86),
    );
    world.add(player);

    _shootTimer.start();
    _enemyTimer.start();

    //debugMode = true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _shootTimer.update(dt);
    _enemyTimer.update(dt);
  }

  void shoot() {
    final enemiesInScreen = world.children.query<Enemy>().length;
    if (isPrintedCompleted && enemiesInScreen == 0) {
      _shootTimer.pause();
    }

    world.add(
      Bullet(
        size: Vector2(width * 0.02, width * 0.02),
        position: player.position,
        velocity: Vector2(0, -1).normalized()..scale(height),
      ),
    );
  }

  Future<void> addEnemies() async {
    final bool isPrintedCompleted = currentLevelPrintedEnemies.enemies.entries
        .every((entry) =>
            currentLevel.enemies.containsKey(entry.key) &&
            entry.value > currentLevel.enemies[entry.key]!);
    final enemyKeys = currentLevel.enemies.keys.toList();
    enemyKeys.removeWhere(
      (enemyType) =>
          currentLevelPrintedEnemies.enemies.containsKey(enemyType) &&
          currentLevel.enemies.containsKey(enemyType) &&
          currentLevelPrintedEnemies.enemies[enemyType]! >
              currentLevel.enemies[enemyType]!,
    );

    if (isPrintedCompleted || enemyKeys.isEmpty) {
      this.isPrintedCompleted = true;
      _enemyTimer.pause();
      return;
    }

    final minWidth = width / 6;
    final maxWidth = width - (width / 6);

    final slowEnemy = Enemy.slow(gameWidth: width, position: Vector2(0, 0));
    final normalEnemy = Enemy.normal(gameWidth: width, position: Vector2(0, 0));
    final fastEnemy = Enemy.fast(gameWidth: width, position: Vector2(0, 0));

    final Map<EnemyType, double> enemySizes = {
      EnemyType.slow: slowEnemy.size.x,
      EnemyType.normal: normalEnemy.size.x,
      EnemyType.fast: fastEnemy.size.x,
    };

    final randomEnemy = rand.nextInt(enemyKeys.length);

    final enemyType = enemyKeys[randomEnemy];

    final double sizeFactor = enemySizes[enemyType] ?? 1;
    final maxEnemies = maxWidth ~/ sizeFactor;
    final numEnemies = rand.nextInt(maxEnemies);

    final List<Enemy> enemies = [];
    final newRand =
        minWidth + rand.nextInt(maxWidth.toInt() - minWidth.toInt() + 1);

    double lastMinorXPosition = newRand;
    double lastMajorXPosition = newRand;

    for (int i = 0; i < numEnemies; i++) {
      final newMinorXPosition =
          lastMinorXPosition - (i > 0 ? sizeFactor * 1.4 : 0);
      final newMajorXPosition =
          lastMajorXPosition + (i > 0 ? sizeFactor * 1.4 : 0);

      if (newMinorXPosition > minWidth) {
        lastMinorXPosition = newMinorXPosition;
        enemies.add(
          getEnemyByEnemyType(enemyType, newMinorXPosition),
        );
      } else if (newMajorXPosition < maxWidth) {
        lastMajorXPosition = newMajorXPosition;
        enemies.add(
          getEnemyByEnemyType(enemyType, newMajorXPosition),
        );
      }
    }

    for (var enemy in enemies) {
      world.add(enemy);
    }
    currentLevelPrintedEnemies.enemies[enemyType] =
        (currentLevelPrintedEnemies.enemies[enemyType] ?? 0) + enemies.length;
  }

  Enemy getEnemyByEnemyType(EnemyType type, double xPosition) {
    switch (type) {
      case EnemyType.slow:
        return Enemy.slow(
          gameWidth: width,
          position: Vector2(xPosition, -100),
        );
      case EnemyType.fast:
        return Enemy.fast(
          gameWidth: width,
          position: Vector2(xPosition, -100),
        );
      case EnemyType.normal:
      default:
        return Enemy.normal(
          gameWidth: width,
          position: Vector2(xPosition, -100),
        );
    }
  }
}
