import 'package:cached_video_player/cached_video_player.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'video_cubit_state.dart';

class VideoMessageCubit extends Cubit<VideoMessageState> {
  final String videoUrl;
  late CachedVideoPlayerController videoPlayerController;
  bool isPlay = false;

  VideoMessageCubit(this.videoUrl) : super(VideoMessageInitial()) {
    videoPlayerController = CachedVideoPlayerController.network(videoUrl)
      ..initialize().then((value) {
        videoPlayerController.setVolume(1);
      });
  }

  void playPauseButtonPressed() {
    isPlay = !videoPlayerController.value.isPlaying;
    if (isPlay) {
      videoPlayerController.play();
    } else {
      videoPlayerController.pause();
    }
    emit(VideoMessageStateChanged(isPlay));
  }

  IconData get playPauseIcon {
    return isPlay ? Icons.pause_circle : Icons.play_circle;
  }

  @override
  Future<void> close() {
    videoPlayerController.dispose();
    return super.close();
  }
}
