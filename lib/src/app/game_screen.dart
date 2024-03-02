import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_game/src/bloc/game/game_bloc.dart';
import 'package:garbage_game/src/bloc/power_up/power_up_bloc.dart';
import 'package:garbage_game/src/game.dart';
import 'package:garbage_game/src/spacing.dart';
import 'package:intl/intl.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = Theme.of(context);
    final formatter = NumberFormat('#,###');
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            GameWidget(
              game: GarbageGame(
                gameBloc: context.read<GameBloc>(),
                powerUpBloc: context.read<PowerUpBloc>(),
                scaffoldBackgroundColor: baseTheme.scaffoldBackgroundColor,
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
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 500.0,
                constraints: const BoxConstraints(maxWidth: 500.0),
                padding: const EdgeInsets.all(Spacing.md),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            context.read<GameBloc>().pause();
                          },
                          child: const Text('| |'),
                        ),
                        BlocBuilder<GameBloc, GameState>(
                          builder: (context, state) {
                            return Text(
                              'Lvl ${state.currentLevelNumber}',
                              textAlign: TextAlign.center,
                              style:
                                  baseTheme.textTheme.headlineSmall?.copyWith(
                                color: Colors.green,
                                shadows: [
                                  const Shadow(
                                    offset: Offset(1.7, 1.7),
                                    blurRadius: 0.0,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    BlocBuilder<GameBloc, GameState>(
                      builder: (context, state) {
                        return Text(
                          formatter.format(state.score),
                          textAlign: TextAlign.center,
                          style: baseTheme.textTheme.headlineSmall?.copyWith(
                            color: Colors.green,
                            shadows: [
                              const Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 0.0,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 500.0,
                constraints: const BoxConstraints(maxWidth: 500.0),
                padding: const EdgeInsets.all(Spacing.lg),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: Spacing.xs),
                      child: Image.network(
                        'https://opengameart.org/sites/default/files/heart%20pixel%20art%20254x254.png',
                        height: 25,
                        width: 25,
                      ),
                    ),
                    BlocBuilder<GameBloc, GameState>(
                      builder: (context, state) {
                        return Text(
                          '${state.playerLifePoints}',
                          textAlign: TextAlign.center,
                          style: baseTheme.textTheme.headlineSmall?.copyWith(
                            color: Colors.red,
                            shadows: [
                              const Shadow(
                                offset: Offset(1.7, 1.7),
                                blurRadius: 0.0,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
