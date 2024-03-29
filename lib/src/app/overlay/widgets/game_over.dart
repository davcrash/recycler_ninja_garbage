import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:garbage_game/src/app/widgets/bloc_button.dart';
import 'package:garbage_game/src/bloc/audio/audio_bloc.dart';
import 'package:garbage_game/src/bloc/game/game_bloc.dart';
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
                AppLocalizations.of(context)!.game_over,
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
                final audioBloc = context.read<AudioBloc>();
                audioBloc.playAudio('pause.mp3');
                audioBloc.pause();
                audioBloc.resume();
                context.read<GameBloc>().restart();
              },
              label: AppLocalizations.of(context)!.restart,
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
                gameBloc.restart();
                Navigator.of(context).pushReplacementNamed(
                  "/",
                );
              },
              child: Text(AppLocalizations.of(context)!.exit_to_menu),
            ),
          ),
        ],
      ),
    );
  }
}
