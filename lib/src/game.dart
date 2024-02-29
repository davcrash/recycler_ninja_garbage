import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:garbage_game/src/bloc/game/game_bloc.dart';
import 'package:garbage_game/src/components/enemy.dart';
import 'package:garbage_game/src/components/power_up.dart';
import 'package:garbage_game/src/const/levels.dart';
import 'package:garbage_game/src/models/enemy_type.dart';
import 'package:garbage_game/src/models/power_up_type.dart';

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
    onTick: () => _shoot(),
    repeat: true,
  );

  late final Timer _enemyTimer = Timer(
    1,
    onTick: () => _addEnemies(),
    repeat: true,
  );

  late final Timer _powerUpTimer = Timer(
    .1,
    onTick: () => _addPowerUp(),
    repeat: true,
  );

  Map<EnemyType, int> currentLevelPrintedEnemies = {
    EnemyType.slow: 0,
    EnemyType.normal: 0,
    EnemyType.fast: 0,
  };

  bool isPrintedCompleted = false;
  Map<EnemyType, int> currentEnemies = levels[0].enemies;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    final playerHeight = width * 0.1;
    //status listener
    await add(
      FlameBlocListener<GameBloc, GameState>(
        listenWhen: (prevS, newS) => prevS.status != newS.status,
        bloc: gameBloc,
        onNewState: (state) {
          switch (state.status) {
            case GameStatus.paused:
            case GameStatus.wonLevel:
            case GameStatus.gameOver:
              _restartEnemiesPrintedCounter();
              currentEnemies = state.currentLevel.enemies;
              overlays.add(state.status.name);
              _shootTimer.pause();
              _enemyTimer.pause();
              _powerUpTimer.pause();
              break;

            case GameStatus.restarting:
              _restartEnemiesPrintedCounter();
              _removeEnemiesFromScreen();
              isPrintedCompleted = false;
              currentEnemies = state.currentLevel.enemies;
              break;
            case GameStatus.playing:
            default:
              overlays.remove(GameStatus.paused.name);
              overlays.remove(GameStatus.wonLevel.name);
              overlays.remove(GameStatus.gameOver.name);
              _shootTimer.resume();
              _enemyTimer.resume();
              _powerUpTimer.resume();
              break;
          }
        },
      ),
    );
    //killed listener
    await add(
      FlameBlocListener<GameBloc, GameState>(
        listenWhen: (prevS, newS) => prevS.killedEnemies != newS.killedEnemies,
        bloc: gameBloc,
        onNewState: (state) {
          final enemiesInScreen = world.children.query<Enemy>().length;
          if (isPrintedCompleted && enemiesInScreen <= 1) {
            gameBloc.wonLevel();
            _shootTimer.pause();
          }
        },
      ),
    );

    world.add(PlayArea());

    player = Player(
      size: Vector2(width * 0.08, playerHeight),
      position: Vector2(width / 2, height * 0.86),
    );
    world.add(player);

    _shootTimer.start();
    _enemyTimer.start();
    _powerUpTimer.start();

    //debugMode = true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _shootTimer.update(dt);
    _enemyTimer.update(dt);
    _powerUpTimer.update(dt);
  }

  void _addPowerUp() {
    final hasToPrint = rand.nextBool();
    if (!hasToPrint) return;

    final minWidth = width / 6;
    final maxWidth = width - (width / 6);
    final newRand =
        minWidth + rand.nextInt(maxWidth.toInt() - minWidth.toInt() + 1);
    const typeValues = PowerUpType.values;
    final powerType = typeValues[rand.nextInt(typeValues.length)];

    world.add(
      PowerUp(
        size: Vector2(width * 0.06, width * 0.06),
        position: Vector2(newRand, -100),
        speed: 300,
        type: powerType,
      ),
    );
  }

  void _shoot() {
    world.add(
      Bullet(
        size: Vector2(width * 0.02, width * 0.02),
        position: player.position,
        velocity: Vector2(0, -1).normalized()..scale(height),
      ),
    );
  }

  Future<void> _addEnemies() async {
    final bool isPrintedCompleted = currentLevelPrintedEnemies.entries.every(
        (entry) =>
            currentEnemies.containsKey(entry.key) &&
            entry.value > currentEnemies[entry.key]!);
    final enemyKeys = [...currentEnemies.keys.toList()];

    enemyKeys.removeWhere(
      (enemyType) =>
          currentLevelPrintedEnemies.containsKey(enemyType) &&
          currentEnemies.containsKey(enemyType) &&
          currentLevelPrintedEnemies[enemyType]! > currentEnemies[enemyType]!,
    );

    if (isPrintedCompleted || enemyKeys.isEmpty) {
      this.isPrintedCompleted = true;
      _enemyTimer.pause();
      _powerUpTimer.pause();
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
          _getEnemyByEnemyType(enemyType, newMinorXPosition),
        );
      } else if (newMajorXPosition < maxWidth) {
        lastMajorXPosition = newMajorXPosition;
        enemies.add(
          _getEnemyByEnemyType(enemyType, newMajorXPosition),
        );
      }
    }

    for (var enemy in enemies) {
      world.add(enemy);
    }
    currentLevelPrintedEnemies[enemyType] =
        (currentLevelPrintedEnemies[enemyType] ?? 0) + enemies.length;
  }

  Enemy _getEnemyByEnemyType(EnemyType type, double xPosition) {
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

  void _removeEnemiesFromScreen() {
    final enemiesInScreen = world.children.query<Enemy>();
    for (var enemy in enemiesInScreen) {
      enemy.removeFromParent();
    }
  }

  void _restartEnemiesPrintedCounter() {
    currentLevelPrintedEnemies = {
      EnemyType.slow: 0,
      EnemyType.normal: 0,
      EnemyType.fast: 0,
    };
  }
}
