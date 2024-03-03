import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_game/src/app/widgets/bloc_button.dart';
import 'package:garbage_game/src/bloc/game/game_bloc.dart';
import 'package:garbage_game/src/bloc/score/score_bloc.dart';
import 'package:garbage_game/src/spacing.dart';

class GameOver extends StatelessWidget {
  const GameOver({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'GAME OVER',
                speed: const Duration(milliseconds: 60),
                textAlign: TextAlign.center,
                textStyle: baseTheme.textTheme.headlineLarge?.copyWith(
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
            ],
            totalRepeatCount: 1,
            displayFullTextOnTap: true,
          ),
          const Padding(padding: EdgeInsets.only(top: Spacing.lg)),
          SizedBox(
            width: 150,
            child: BlockButton(
              onPressed: () {
                context.read<GameBloc>().restart();
              },
              label: 'RESTART',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: Spacing.xs),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: baseTheme.colorScheme.error,
              ),
              onPressed: () {
                final gameBloc = context.read<GameBloc>();
                final gameBlocState = gameBloc.state;
                context.read<ScoreBloc>().updateData(
                      enemiesKilled: gameBlocState.killedEnemies,
                      score: gameBlocState.score,
                      lvl: gameBlocState.currentLevelNumber,
                    );
                gameBloc.restart();
                Navigator.of(context).pushReplacementNamed(
                  "/",
                );
              },
              child: const Text("Exit to menu"),
            ),
          ),
        ],
      ),
    );
  }
}
