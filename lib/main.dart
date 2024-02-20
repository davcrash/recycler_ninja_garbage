import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_game/src/app.dart';
import 'package:garbage_game/src/bloc/game/game_bloc.dart';

void main() {
  runApp(
    BlocProvider<GameBloc>(
      create: (context) => GameBloc(),
      child: const GameApp(),
    ),
  );
}
