import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_game/src/app.dart';
import 'package:garbage_game/src/bloc/audio/audio_bloc.dart';
import 'package:garbage_game/src/bloc/game/game_bloc.dart';
import 'package:garbage_game/src/bloc/overlay/overlay_bloc.dart';
import 'package:garbage_game/src/bloc/power_up/power_up_bloc.dart';
import 'package:garbage_game/src/bloc/score/score_bloc.dart';
import 'package:garbage_game/src/helpers.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.images.loadAllImages();
  if (isPlatformBigScreen() && !kIsWeb) {
    await windowManager.ensureInitialized();
    const size = Size(400.0, 800.0);
    WindowManager.instance.setSize(size);
    WindowManager.instance.setMinimumSize(size);
  }
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom,
  ]);

  await FlameAudio.audioCache.loadAll([
    'bomb.mp3',
    'bounce.mp3',
    'heal.mp3',
    'kill.mp3',
    'kunai.mp3',
    'music.mp3',
    'pause.mp3',
    'shuriken.mp3',
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
        BlocProvider<AudioBloc>(
          create: (context) => AudioBloc()..init(),
        ),
      ],
      child: const GameApp(),
    ),
  );
}
