import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_game/src/app/overlay/widgets/power_up_image.dart';
import 'package:garbage_game/src/app/widgets/bloc_button.dart';
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
            Text(
              "PAUSED",
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
                                "Lvl. ${mapCopy[PowerUpType.machineGun] ?? 0}",
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
                                "Lvl. ${mapCopy[PowerUpType.bounceBullet] ?? 0}",
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
                                "Lvl. ${mapCopy[PowerUpType.bigGun] ?? 0}",
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
                final gameBloc = context.read<GameBloc>();
                gameBloc.pause();
              },
              label: 'RESUME',
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
      ),
    );
  }
}
