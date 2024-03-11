import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:garbage_game/src/app/overlay/widgets/power_up_image.dart';
import 'package:garbage_game/src/app/widgets/bloc_button.dart';
import 'package:garbage_game/src/bloc/audio/audio_bloc.dart';
import 'package:garbage_game/src/bloc/game/game_bloc.dart';
import 'package:garbage_game/src/bloc/power_up/power_up_bloc.dart';
import 'package:garbage_game/src/bloc/score/score_bloc.dart';
import 'package:garbage_game/src/models/power_up_type.dart';
import 'package:garbage_game/src/spacing.dart';

class PauseMenu extends StatelessWidget {
  const PauseMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = Theme.of(context);
    return Material(
      color: Colors.white,
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            15,
          ),
          bottomRight: Radius.circular(
            15,
          ),
        ),
      ),
      child: Container(
        width: 350.0,
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: BlocBuilder<AudioBloc, AudioState>(
                    builder: (context, state) {
                      return IconButton(
                        icon: Icon(
                          (state is AudioMuted)
                              ? Icons.volume_off
                              : Icons.volume_up,
                          color: baseTheme.colorScheme.secondary,
                        ),
                        onPressed: () {
                          context.read<AudioBloc>().mutedButtonPressed(
                                resume: context.read<GameBloc>().state.status !=
                                    GameStatus.paused,
                              );
                        },
                      );
                    },
                  ),
                ),
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.paused,
                    textAlign: TextAlign.center,
                    style: baseTheme.textTheme.headlineLarge?.copyWith(
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
                ),
              ],
            ),
            BlocBuilder<PowerUpBloc, PowerUpState>(
              builder: (context, state) {
                Map<PowerUpType, int> mapCopy = {...state.powersLevel}
                  ..removeWhere(
                    (key, value) =>
                        key == PowerUpType.nuclearBomb ||
                        key == PowerUpType.heal,
                  );
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: Spacing.lg),
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: Spacing.xs),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 30,
                                width: 30,
                                child: PowerUpImage(
                                  powerUpType: PowerUpType.machineGun,
                                  height: 30,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: Spacing.xs),
                              ),
                              Text(
                                "${AppLocalizations.of(context)!.lvl}. ${mapCopy[PowerUpType.machineGun] ?? 0}",
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: Spacing.xs),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 30,
                                width: 30,
                                child: PowerUpImage(
                                  powerUpType: PowerUpType.bounceBullet,
                                  height: 30,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: Spacing.xs),
                              ),
                              Text(
                                "${AppLocalizations.of(context)!.lvl}. ${mapCopy[PowerUpType.bounceBullet] ?? 0}",
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: Spacing.xs),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 30,
                                width: 30,
                                child: PowerUpImage(
                                  powerUpType: PowerUpType.bigGun,
                                  height: 30,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: Spacing.xs),
                              ),
                              Text(
                                "${AppLocalizations.of(context)!.lvl}. ${mapCopy[PowerUpType.bigGun] ?? 0}",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            BlockButton(
              onPressed: () {
                final audioBloc = context.read<AudioBloc>();
                context.read<GameBloc>().pause();
                audioBloc.pause();
                audioBloc.playAudio('pause.mp3');
                audioBloc.resume();
              },
              label: AppLocalizations.of(context)!.resume,
            ),
            Padding(
              padding: const EdgeInsets.only(top: Spacing.xs),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: baseTheme.colorScheme.error,
                ),
                onPressed: () {
                  final audioBloc = context.read<AudioBloc>();
                  audioBloc.pause();
                  audioBloc.playAudio('pause.mp3');
                  audioBloc.resume();

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
                child: Text(AppLocalizations.of(context)!.exit_to_menu),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
