import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';

part 'audio_state.dart';

class AudioBloc extends Cubit<AudioState> {
  AudioBloc() : super(AudioSound());

  AudioPlayer? audioPlayer;

  void init() async {
    if (kIsWeb) {
      emit(AudioMuted());
      return;
    }
    audioPlayer = await FlameAudio.loopLongAudio('music.mp3', volume: 0.5);
  }

  void restart() {
    if (state is AudioMuted) return;
    audioPlayer?.stop();
    audioPlayer?.resume();
  }

  void pause() {
    if (state is AudioMuted) return;
    audioPlayer?.pause();
  }

  void resume() {
    if (state is AudioMuted) return;
    audioPlayer?.resume();
  }

  void mutedButtonPressed({bool resume = true}) async {
    if (state is AudioSound) {
      audioPlayer?.stop();
      emit(AudioMuted());
      return;
    }
    if (resume) audioPlayer?.resume();
    audioPlayer ??= await FlameAudio.loopLongAudio('music.mp3', volume: 0.5);
    emit(AudioSound());
  }

  void playAudio(String name, {double volume = 1.0}) async {
    try {
      if (state is AudioSound) {
        await FlameAudio.play(name, volume: volume);
      }
    } catch (_) {}
  }
}
