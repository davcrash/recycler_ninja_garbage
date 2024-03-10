import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_game/src/app.dart';
import 'package:garbage_game/src/bloc/game/game_bloc.dart';
import 'package:garbage_game/src/bloc/overlay/overlay_bloc.dart';
import 'package:garbage_game/src/bloc/power_up/power_up_bloc.dart';
import 'package:garbage_game/src/bloc/score/score_bloc.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  if (Platform.isWindows || Platform.isMacOS) {
    const size = Size(400.0, 800.0);
    WindowManager.instance.setSize(size);
    WindowManager.instance.setMinimumSize(size);
  }
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  ]);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<GameBloc>(
          create: (context) => GameBloc(),
        ),
        BlocProvider<PowerUpBloc>(
          create: (context) => PowerUpBloc(),
        ),
        BlocProvider<ScoreBloc>(
          create: (context) => ScoreBloc()..init(),
        ),
        BlocProvider<OverlayBloc>(
          create: (context) => OverlayBloc(),
        ),
      ],
      child: const GameApp(),
    ),
  );
}
