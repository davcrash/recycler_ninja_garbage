import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flame_audio/flame_audio.dart';

part 'audio_state.dart';

class AudioBloc extends Cubit<AudioState> {
  AudioBloc({
    required this.audioPlayer,
  }) : super(AudioSound());

  final AudioPlayer audioPlayer;

  void restart() {
    if (state is AudioMuted) return;
    audioPlayer.stop();
    audioPlayer.resume();
  }

  void pause() {
    if (state is AudioMuted) return;
    audioPlayer.pause();
  }

  void resume() {
    if (state is AudioMuted) return;
    audioPlayer.resume();
  }

  void mutedButtonPressed({bool resume = true}) {
    if (state is AudioSound) {
      audioPlayer.stop();
      emit(AudioMuted());
      return;
    }
    if (resume) audioPlayer.resume();
    emit(AudioSound());
  }

  void playAudio(String name, {double volume = 1.0}) {
    try {
      if (state is AudioSound) {
        FlameAudio.play(name, volume: volume);
      }
    } catch (_) {}
  }
}
