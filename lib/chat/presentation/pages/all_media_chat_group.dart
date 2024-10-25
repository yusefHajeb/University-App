import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/chat/domain/entities/student_entity.dart';
import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/presentation/cubit/chat/chat_cubit.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/preview_message_content/image_message_preview.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/preview_message_content/video_message_preview.dart';
import 'package:university/chat/presentation/widgets/theme/style.dart';
import 'package:university/features/AllFeatures/presentation/resources/assets_mananger.dart';
import 'package:university/generated/Links.dart';
import 'package:university/generated/helper/date_converter.dart';
import 'package:university/generated/helper/time_extension.dart';
import 'package:university/chat/presentation/cubit/video_cubit/video_cubit_cubit.dart';

import '../../../core/constant/varibal.dart';

class AllMediaChatGroup extends StatefulWidget {
  final StudentEntity uid;
  final String? query;

  const AllMediaChatGroup({Key? key, required this.uid, this.query})
      : super(key: key);

  @override
  AllMediaChatGroupState createState() => AllMediaChatGroupState();
}

class AllMediaChatGroupState extends State<AllMediaChatGroup> {
  List<TextMessageEntity> listMessagefilter = [];
  final Map<String, List<TextMessageEntity>> groupedMessages = {};

  Map<String, List<TextMessageEntity>> groupMessagesByMonth(
      List<TextMessageEntity> messages) {
    groupedMessages.clear();
    for (TextMessageEntity message in messages) {
      DateTime dateTime = message.time!;
      String month =
          '${dateTime.year}-${dateTime.month}'; // Generate a key in the format 'YYYY-MM' for grouping
      print(month);
      if (groupedMessages.containsKey(month)) {
        groupedMessages[month]!.add(message);
      } else {
        groupedMessages[month] = [message];
      }
    }

    return groupedMessages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, userState) {
          if (userState is ChatLoaded) {
            print(widget.uid);
            var listMessage = userState.messages;
            listMessagefilter = [];
            for (var element in listMessage) {
              if (element.type == "IMAGE" || element.type == "VEDIO")
                listMessagefilter.add(element);
            }
            Map<String, List<TextMessageEntity>> groupedMessages =
                groupMessagesByMonth(listMessagefilter);
            return Container(
              child: Column(
                children: [
                  Expanded(
                      child: listMessagefilter.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.perm_media_sharp,
                                    size: 40,
                                    color: Colors.white.withOpacity(.4),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "لا توجد وسائط حاليا",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(.2)),
                                  )
                                ],
                              ),
                            )
                          : ListView.builder(
                              reverse: true,
                              itemCount: groupedMessages.length,
                              itemBuilder: (context, index) {
                                String month =
                                    groupedMessages.keys.elementAt(index);
                                List<TextMessageEntity> imageMessages =
                                    groupedMessages.values.elementAt(index);
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GridView.count(
                                      crossAxisCount:
                                          3, // Number of images per row
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children:
                                          imageMessages.map((imageMessage) {
                                        // Replace 'Image.network' with your own widget to display the image
                                        if (imageMessage.type == "VEDIO") {
                                          return my_show_media_vedio(
                                            Messagemedia: imageMessage,
                                          );
                                        } else {
                                          return my_show_media_image(
                                            Messagemedia: imageMessage,
                                          );
                                        }
                                      }).toList(),
                                    ),
                                    TagChatTimeMedia(
                                        dateTime: imageMessages[index].time!),
                                  ],
                                );
                              },
                            ))
                ],
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class my_show_media_image extends StatelessWidget {
  const my_show_media_image({
    Key? key,
    required this.Messagemedia,
  }) : super(key: key);

  final TextMessageEntity Messagemedia;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ImageMessagePreview.routeName,
            arguments: Messagemedia);
      },
      child: Container(
          width: 200,
          height: 200,
          margin: const EdgeInsets.all(1),
          child: CachedNetworkImage(
            imageUrl:
                "${Constants.linkImageRootImageChat}/${Messagemedia.url_madia}",
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                SizedBox(
                    height: 50,
                    width: 50,
                    child: Container(
                        margin: EdgeInsets.all(20),
                        child: CircularProgressIndicator())),
            errorWidget: (context, url, error) =>
                Image.asset(ImageAssets.profile),
          )),
    );
  }
}

class my_show_media_vedio extends StatelessWidget {
  const my_show_media_vedio({
    Key? key,
    required this.Messagemedia,
  }) : super(key: key);

  final TextMessageEntity Messagemedia;

  @override
  Widget build(BuildContext context) {
    final cubit = VideoMessageCubit(
        "${Constants.linkImageRootImageChat}/${Messagemedia.url_madia!}");
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          VideoMessagePreview.routeName,
          arguments: Messagemedia,
        );
      },
      child: Container(
          width: 200,
          height: 200,
          margin: const EdgeInsets.all(1),
          child: Stack(
            children: [
              CachedVideoPlayer(cubit.videoPlayerController),
              Center(
                child: Icon(
                  cubit.playPauseIcon,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            ],
          )),
    );
  }
}

class TagChatTimeMedia extends StatelessWidget {
  final DateTime dateTime;

  const TagChatTimeMedia({Key? key, required this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        color: kBlackColor2,
        // height: 20,
        width: mq.width,
        //margin: const EdgeInsets.all(5),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: Text(
          dateTime.getMonthAndYeer,
          style: TextStyle(
              color: kGreyColor,
              fontWeight: FontWeight.bold,
              fontSize: mq.width * 0.04),
        ),
      ),
    );
  }
}
