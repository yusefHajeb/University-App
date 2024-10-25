import 'dart:io';

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
import 'package:university/generated/Links.dart';
import 'package:university/generated/helper/date_converter.dart';
import 'package:university/generated/helper/time_extension.dart';
import 'package:university/chat/presentation/cubit/video_cubit/video_cubit_cubit.dart';
import 'package:http/http.dart' as http;

class AllDocumentChatGroup extends StatefulWidget {
  final StudentEntity uid;
  final String? query;

  const AllDocumentChatGroup({Key? key, required this.uid, this.query})
      : super(key: key);

  @override
  AllDocumentChatGroupState createState() => AllDocumentChatGroupState();
}

class AllDocumentChatGroupState extends State<AllDocumentChatGroup> {
  List<TextMessageEntity> listMessagefilter = [];
  final Map<String, List<TextMessageEntity>> groupedMessages = {};
  String myfilesize = "64 kb";
  getFileDetails(String fileUrl) async {
    http.Response response = await http.head(Uri.parse(fileUrl));
    if (response.statusCode == 200) {
      var contentLength = response.headers['content-length'];
      if (contentLength != null) {
        double fileSizeInMB = double.parse(contentLength) / 1048576;
        return '${fileSizeInMB.toStringAsFixed(2)} MB';
      } else {
        print('Could not retrieve file size.');
      }
    } else {
      print(
          'Failed to retrieve file details. Response status code: ${response.statusCode}');
    }
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
              if (element.type == "FILE") listMessagefilter.add(element);
            }
            listMessagefilter = listMessagefilter.reversed.toList();
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
                                    Icons.person,
                                    size: 40,
                                    color: Colors.white.withOpacity(.4),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "لا توجد ملفات حاليا",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(.2)),
                                  )
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: listMessagefilter.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    my_show_media_file(
                                      Messagemedia: listMessagefilter[index],
                                      myfilesize: myfilesize,
                                    ),
                                    if (index == 0 ||
                                        !DateConverter.getIsSameDay(
                                            listMessagefilter[index].time!,
                                            listMessagefilter[index - 1].time!))
                                      TagChatTimeMedia(
                                          dateTime:
                                              listMessagefilter[index].time!),
                                  ],
                                );
                              },
                            ))
                ],
              ),
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.white.withOpacity(.4),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "لا توجد ملفات حاليا",
                  style: TextStyle(color: Colors.white.withOpacity(.2)),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class my_show_media_file extends StatelessWidget {
  my_show_media_file({
    Key? key,
    required this.Messagemedia,
    required this.myfilesize,
  }) : super(key: key);

  final TextMessageEntity Messagemedia;
  final String myfilesize;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          height: 100,
          margin: const EdgeInsets.all(1),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                child: Icon(
                  Icons.file_copy,
                  size: 30,
                  color: kBackgroundColor,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${Messagemedia.url_madia!.split('.').first}',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: kBackgroundColor,
                        height: 1.2,
                        fontSize: mq.width * .04,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          Messagemedia.url_madia!.split('.').last,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: kBlueLight2,
                            height: 1.2,
                            fontSize: mq.width * .04,
                          ),
                        ),
                        Text(
                          myfilesize,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: kBackgroundColor,
                            height: 1.2,
                            fontSize: mq.width * .04,
                          ),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 0.2,
                      color: kBlueLight,
                    ),
                  ],
                ),
              )
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
