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
    audioPlayer.stop();
    audioPlayer.resume();
  }

  void pause() {
    audioPlayer.pause();
  }

  void resume() {
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
}
