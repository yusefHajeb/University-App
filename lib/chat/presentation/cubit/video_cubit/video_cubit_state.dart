part of 'video_cubit_cubit.dart';

abstract class VideoMessageState extends Equatable {
  const VideoMessageState();

  @override
  List<Object?> get props => [];
}

class VideoMessageInitial extends VideoMessageState {}

class VideoMessageStateChanged extends VideoMessageState {
  final bool isPlay;

  VideoMessageStateChanged(this.isPlay);

  @override
  List<Object?> get props => [];

  bool get isPlay_ => isPlay; // Define the getter here
}
