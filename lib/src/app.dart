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
                  BlocBuilder<GameBloc, GameState>(
                    builder: (context, state) {
                      return Text('${state.status}');
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<GameBloc>().pause();
                    },
                    child: const Text('pause'),
                  ),
                  Expanded(
                    child: GameWidget(
                      game: GarbageGame(
                        gameBloc: context.read<GameBloc>(),
                      ),
                      overlayBuilderMap: {
                        GameStatus.paused.name: (context, game) => const Center(
                              child: Text("PAUSED"),
                            ),
                      },
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
