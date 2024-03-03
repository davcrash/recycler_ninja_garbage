import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_game/src/app/overlay/overlay_screen.dart';
import 'package:garbage_game/src/bloc/game/game_bloc.dart';
import 'package:garbage_game/src/bloc/overlay/overlay_bloc.dart' as bloc;
import 'package:garbage_game/src/bloc/power_up/power_up_bloc.dart';
import 'package:garbage_game/src/bloc/score/score_bloc.dart';
import 'package:garbage_game/src/game.dart';
import 'package:garbage_game/src/helpers.dart';
import 'package:garbage_game/src/spacing.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = Theme.of(context);

    return BlocListener<GameBloc, GameState>(
      listenWhen: (prevS, newS) => prevS.status != newS.status,
      listener: (context, state) {
        if (state.status == GameStatus.gameOver) {
          context.read<ScoreBloc>().updateData(
                enemiesKilled: state.killedEnemies,
                score: state.score,
                lvl: state.currentLevelNumber,
              );
        }
      },
      child: MediaQuery.removePadding(
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
                  overlayBloc: context.read<bloc.OverlayBloc>(),
                  scaffoldBackgroundColor: baseTheme.scaffoldBackgroundColor,
                ),
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
                                  color: baseTheme.colorScheme.primary,
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
                            numberFormatter.format(state.score),
                            textAlign: TextAlign.center,
                            style: baseTheme.textTheme.headlineSmall?.copyWith(
                              color: baseTheme.colorScheme.primary,
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
              ),
              BlocBuilder<bloc.OverlayBloc, bloc.OverlayState>(
                builder: (context, state) {
                  if (state is bloc.OverlayShowed) {
                    return OverlayScreen(
                      type: state.type,
                      powerUpType: state.powerUpType,
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
