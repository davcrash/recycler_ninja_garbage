import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_game/src/bloc/game/game_bloc.dart';
import 'package:garbage_game/src/game.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: [
                  BlocBuilder<GameBloc, int>(
                    builder: (context, state) {
                      return Text('$state');
                    },
                  ),
                  Expanded(
                    child: GameWidget(
                      game: GarbageGame(
                        gameBloc: context.read<GameBloc>(),
                      ),
                      /* overlayBuilderMap: {
                            PlayState.welcome.name: (context, game) =>
                                const OverlayScreen(
                                  title: 'TAP TO PLAY',
                                  subtitle: 'Use arrow keys or swipe',
                                ),
                            PlayState.gameOver.name: (context, game) =>
                                const OverlayScreen(
                                  title: 'G A M E   O V E R',
                                  subtitle: 'Tap to Play Again',
                                ),
                            PlayState.won.name: (context, game) =>
                                const OverlayScreen(
                                  title: 'Y O U   W O N ! ! !',
                                  subtitle: 'Tap to Play Again',
                                ),
                          }, */
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
