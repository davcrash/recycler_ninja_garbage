import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_game/src/bloc/game/game_bloc.dart';
import 'package:garbage_game/src/spacing.dart';

class WonLevel extends StatelessWidget {
  const WonLevel({super.key});

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
                'MISSION\nCOMPLETE!',
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
          BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: Spacing.sm,
                ),
                child: Text("Lvl ${state.currentLevelNumber - 1} COMPLETED"),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              context.read<GameBloc>().pause();
            },
            child: const Text('CONTINUE'),
          ),
        ],
      ),
    );
  }
}
