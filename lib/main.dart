import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_game/src/app.dart';
import 'package:garbage_game/src/bloc/game/game_bloc.dart';
import 'package:garbage_game/src/bloc/power_up/power_up_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<GameBloc>(
          create: (context) => GameBloc(),
        ),
        BlocProvider<PowerUpBloc>(
          create: (context) => PowerUpBloc(),
        ),
      ],
      child: const GameApp(),
    ),
  );
}
