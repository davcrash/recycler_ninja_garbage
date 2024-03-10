import 'dart:io';

import 'package:flame/components.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_game/src/app/widgets/bloc_button.dart';
import 'package:garbage_game/src/bloc/audio/audio_bloc.dart';
import 'package:garbage_game/src/bloc/score/score_bloc.dart';
import 'package:garbage_game/src/helpers.dart';
import 'package:garbage_game/src/spacing.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  void _goToGame(context) {
    Navigator.of(context).pushReplacementNamed(
      "/game",
    );
  }

  void _goToCredits(context) {
    Navigator.of(context).pushReplacementNamed(
      "/credits",
    );
  }

  @override
  Widget build(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobileLayout = shortestSide < 500;
    final baseTheme = Theme.of(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.5],
            colors: [
              Color(0xffdbd5c6),
              Color(0xff94979e),
            ],
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage("assets/images/sprites/map.png"),
              fit: useMobileLayout ? BoxFit.fill : BoxFit.fitHeight,
            ),
          ),
          child: RawKeyboardListener(
            autofocus: true,
            focusNode: FocusNode(),
            onKey: (RawKeyEvent event) {
              if (event.isKeyPressed(LogicalKeyboardKey.enter) ||
                  event.isKeyPressed(LogicalKeyboardKey.space)) {
                final audioBloc = context.read<AudioBloc>();
                audioBloc.restart();

                _goToGame(context);
              }
            },
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.md),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "RECYCLER NINJA\nGARBAGE",
                              textAlign: TextAlign.center,
                              style:
                                  baseTheme.textTheme.headlineLarge?.copyWith(
                                color: baseTheme.colorScheme.primary,
                                shadows: [
                                  const Shadow(
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 0.0,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: Spacing.lg),
                            ),
                            /* SpriteAnimationWidget.asset(
                              path: 'sprites/player/idle.png',
                              data: SpriteAnimationData.sequenced(
                                amountPerRow: 1,
                                amount: 2,
                                stepTime: 0.2,
                                textureSize: Vector2.all(60),
                              ),
                            ), */
                            SizedBox(
                              height: 250,
                              width: 250,
                              child: SpriteWidget.asset(
                                path: 'sprites/player/main.png',
                                srcPosition: Vector2.all(0),
                                srcSize: Vector2.all(50),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: Spacing.lg),
                            ),
                            BlocBuilder<ScoreBloc, ScoreState>(
                              builder: (context, state) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: Spacing.sm,
                                      ),
                                      child: ScoreSection(
                                        score: state.enemiesKilled,
                                        label: 'Recycled enemies',
                                        isBigger: true,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: Spacing.sm,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ScoreSection(
                                            score: state.maxScore,
                                            label: 'Max recycling score',
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                              right: Spacing.md,
                                            ),
                                          ),
                                          ScoreSection(
                                            score: state.maxLvl,
                                            label: 'Max Lvl',
                                          ),
                                        ],
                                      ),
                                    ),
                                    ScoreSection(
                                      score: state.maxEnemiesKilled,
                                      label: 'Max recycled enemies',
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: Spacing.md),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.feed_outlined,
                                            color:
                                                baseTheme.colorScheme.secondary,
                                          ),
                                          onPressed: () {
                                            _goToCredits(context);
                                          },
                                        ),
                                        BlocBuilder<AudioBloc, AudioState>(
                                          builder: (context, state) {
                                            return IconButton(
                                              icon: Icon(
                                                (state is AudioMuted)
                                                    ? Icons.volume_off
                                                    : Icons.volume_up,
                                                color: baseTheme
                                                    .colorScheme.secondary,
                                              ),
                                              onPressed: () {
                                                context
                                                    .read<AudioBloc>()
                                                    .mutedButtonPressed();
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    BlockButton(
                      width: Platform.isIOS ||
                              Platform.isAndroid ||
                              Platform.isFuchsia
                          ? double.infinity
                          : 400,
                      onPressed: () {
                        final audioBloc = context.read<AudioBloc>();
                        audioBloc.restart();

                        _goToGame(context);
                      },
                      label: "PLAY",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ScoreSection extends StatelessWidget {
  const ScoreSection({
    super.key,
    required this.score,
    required this.label,
    this.isBigger = false,
  });

  final int score;
  final String label;
  final bool isBigger;

  @override
  Widget build(BuildContext context) {
    final baseTheme = Theme.of(context);
    return Column(
      children: [
        Text(
          numberFormatter.format(score),
          style: isBigger
              ? baseTheme.textTheme.headlineMedium?.copyWith(
                  color: baseTheme.colorScheme.primary,
                  shadows: [
                    const Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 0.0,
                      color: Colors.black,
                    ),
                  ],
                )
              : baseTheme.textTheme.headlineSmall?.copyWith(
                  color: baseTheme.colorScheme.primary,
                  shadows: [
                    const Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 0.0,
                      color: Colors.black,
                    ),
                  ],
                ),
        ),
        Text(label),
      ],
    );
  }
}
