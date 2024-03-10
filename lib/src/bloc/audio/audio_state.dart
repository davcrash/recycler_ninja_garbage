part of 'audio_bloc.dart';

sealed class AudioState extends Equatable {
  const AudioState();

  @override
  List<Object> get props => [];
}

final class AudioSound extends AudioState {}

final class AudioMuted extends AudioState {}
