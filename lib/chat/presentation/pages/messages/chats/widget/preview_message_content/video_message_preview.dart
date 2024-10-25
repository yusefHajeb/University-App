import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/preview_message_content/app_bar_message_preview.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/generated/Links.dart';
import '../../../../../cubit/video_cubit/video_cubit_cubit.dart';

class VideoMessagePreview extends StatelessWidget {
  static const routeName = "video-message-preview";
  final TextMessageEntity messageData;
  const VideoMessagePreview({Key? key, required this.messageData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = VideoMessageCubit(
        "${Constants.linkImageRootImageChat}/${messageData.url_madia!}");

    return BlocProvider(
      create: (_) => cubit,
      child: BlocBuilder<VideoMessageCubit, VideoMessageState>(
        builder: (context, state) {
          bool isPlay = false;
          if (state is VideoMessageStateChanged) {
            isPlay = state.isPlay;
          }
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBarMessagePreview(messageData: messageData),
            body: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  children: [
                    CachedVideoPlayer(cubit.videoPlayerController),
                    buildPlayPauseButton(context, isPlay),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildPlayPauseButton(BuildContext context, bool isPlay) {
    final cubit = BlocProvider.of<VideoMessageCubit>(context);
    return Align(
      alignment: Alignment.center,
      child: IconButton(
        onPressed: () {
          cubit.playPauseButtonPressed();
        },
        icon: Icon(
          cubit.playPauseIcon,
          size: 40,
          color: Colors.grey,
        ),
      ),
    );
  }
}
