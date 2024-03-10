import 'dart:io';

import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_game/src/app.dart';
import 'package:garbage_game/src/bloc/audio/audio_bloc.dart';
import 'package:garbage_game/src/bloc/game/game_bloc.dart';
import 'package:garbage_game/src/bloc/overlay/overlay_bloc.dart';
import 'package:garbage_game/src/bloc/power_up/power_up_bloc.dart';
import 'package:garbage_game/src/bloc/score/score_bloc.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.images.loadAllImages();
  await windowManager.ensureInitialized();
  if (Platform.isWindows || Platform.isMacOS) {
    const size = Size(400.0, 800.0);
    WindowManager.instance.setSize(size);
    WindowManager.instance.setMinimumSize(size);
  }
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  ]);

  await FlameAudio.audioCache.loadAll([
    'bomb.mp3',
    'bounce.mp3',
    'heal.mp3',
    'kunai.mp3',
    'music.mp3',
    'pause.mp3',
    'shuriken.mp3',
  ]);
  final audioPlayer = await FlameAudio.loopLongAudio('music.mp3', volume: 0.5);

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
        BlocProvider<AudioBloc>(
          create: (context) => AudioBloc(
            audioPlayer: audioPlayer,
          ),
        ),
      ],
      child: const GameApp(),
    ),
  );
}
