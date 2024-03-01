import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_game/src/bloc/game/game_bloc.dart';
import 'package:garbage_game/src/bloc/power_up/power_up_bloc.dart';
import 'package:garbage_game/src/game.dart';

import 'app/main_screen.dart';

class GameApp extends StatelessWidget {
  const GameApp({super.key});
  final buttonShape = const BeveledRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(
        7,
      ),
      bottomRight: Radius.circular(
        7,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    /* return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: 'FutilePro',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(shape: buttonShape),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(shape: buttonShape),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(shape: buttonShape),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(shape: buttonShape),
        ),
        buttonTheme: ButtonThemeData(
          shape: buttonShape,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green.shade700,
        ),
      ),
      home: const MainScreen(),
    ); */
    return MaterialApp(
      theme: ThemeData(fontFamily: 'FutilePro'),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "HELLO | |",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: [
                  BlocBuilder<GameBloc, GameState>(
                    builder: (context, state) {
                      return Text(
                        '${state.status} LEVEL:${state.currentLevelNumber} KILL:${state.killedEnemies} Score: ${state.score}, life ${state.playerLifePoints}',
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<GameBloc>().pause();
                    },
                    child: const Text('pause'),
                  ),
                  Expanded(
                    child: GameWidget(
                      game: GarbageGame(
                        gameBloc: context.read<GameBloc>(),
                        powerUpBloc: context.read<PowerUpBloc>(),
                      ),
                      overlayBuilderMap: {
                        GameStatus.paused.name: (context, game) => Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text("PAUSED"),
                                  BlocBuilder<PowerUpBloc, PowerUpState>(
                                    builder: (context, state) {
                                      return Text(
                                        '${state.powersLevel}',
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                        GameStatus.wonLevel.name: (context, game) => Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text("WON LEVEL"),
                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<GameBloc>().pause();
                                    },
                                    child: const Text('continue'),
                                  ),
                                ],
                              ),
                            ),
                        GameStatus.gameOver.name: (context, game) => Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text("Game over"),
                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<GameBloc>().restart();
                                    },
                                    child: const Text('restart'),
                                  ),
                                ],
                              ),
                            ),
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
