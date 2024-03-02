import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_game/src/app/widgets/bloc_button.dart';
import 'package:garbage_game/src/bloc/score/score_bloc.dart';
import 'package:garbage_game/src/helpers.dart';
import 'package:garbage_game/src/spacing.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Colors.green,
                          shadows: [
                            const Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 0.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: Spacing.lg)),
                      //TODO: change placeholder to image
                      const Placeholder(
                        child: SizedBox(
                          height: 250,
                          width: 250,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: Spacing.lg)),
                      BlocBuilder<ScoreBloc, ScoreState>(
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Max recycling score: ${numberFormatter.format(state.maxScore)}',
                              ),
                              Text(
                                'Max Lvl: ${numberFormatter.format(state.maxLvl)}',
                              ),
                              Text(
                                'Max recycled enemies: ${numberFormatter.format(state.maxEnemiesKilled)}',
                              ),
                              Text(
                                'Total enemies recycled: ${numberFormatter.format(state.enemiesKilled)}',
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
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(
                    "/game",
                  );
                },
                label: "PLAY",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
