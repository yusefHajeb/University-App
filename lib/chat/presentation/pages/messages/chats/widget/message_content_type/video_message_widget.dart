import 'package:bubble/bubble.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/presentation/cubit/video_cubit/video_cubit_cubit.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/preview_message_content/video_message_preview.dart';
import 'package:university/chat/presentation/widgets/theme/style.dart';
import 'package:equatable/equatable.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/generated/Links.dart';

class VideoMessageWidget extends StatelessWidget {
  final TextMessageEntity messageData;
  final bool isSender;

  const VideoMessageWidget({
    Key? key,
    required this.messageData,
    required this.isSender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = VideoMessageCubit(
        "${Constants.linkImageRootImageChat}/${messageData.url_madia!}");

    return BlocProvider<VideoMessageCubit>(
      create: (_) => cubit,
      child: BlocBuilder<VideoMessageCubit, VideoMessageState>(
        builder: (context, state) {
          bool isPlay = false;
          if (state is VideoMessageStateChanged) {
            isPlay = state.isPlay;
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment:
                  isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.83,
                  ),
                  child: Container(
                    child: Bubble(
                      color: isSender ? ColorBubbleSender : ColorBubbleMe,
                      nip: isSender ? BubbleNip.leftTop : BubbleNip.rightBottom,
                      shadowColor: Colors.black12,
                      elevation: 3,
                      radius: Radius.circular(16),
                      child: Column(
                        crossAxisAlignment: isSender
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          isSender
                              ? Text(
                                  messageData.senderName!.split(' ').first +
                                      " " +
                                      messageData.senderName!.split(' ').last,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: textPrimaryColor,
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(height: 2),
                          Column(
                            crossAxisAlignment: isSender
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.end,
                            children: [
                              Container(
                                height: 250,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.blue,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      VideoMessagePreview.routeName,
                                      arguments: messageData,
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: CachedVideoPlayer(
                                              cubit.videoPlayerController,
                                            ),
                                          ),
                                          buildPlayPauseButton(context, isPlay),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2),
                          Text(
                            DateFormat('hh:mm a').format(messageData.time!),
                            textAlign:
                                isSender ? TextAlign.right : TextAlign.left,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
          size: 50,
          color: Colors.grey,
        ),
      ),
    );
  }
}
