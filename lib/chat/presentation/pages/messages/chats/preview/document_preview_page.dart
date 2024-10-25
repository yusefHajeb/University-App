import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/chat/domain/entities/single_chat_entity.dart';
import 'package:university/chat/domain/entities/student_entity.dart';
import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/presentation/cubit/chat/chat_cubit.dart';
import 'package:university/chat/presentation/pages/messages/chats/preview/bottom_field_preview.dart';
import 'package:university/chat/presentation/widgets/theme/style.dart';

// ignore: must_be_immutable
class DocumentPreviewPage extends StatefulWidget {
  static const routeName = "document-preview";

  PlatformFile DocumentFilePath;
  final String? receiverId;
  final StudentEntity? userData;
  final SingleChatEntity singleChatEntity;

  DocumentPreviewPage(
      {Key? key,
      required this.DocumentFilePath,
      this.receiverId,
      this.userData,
      required this.singleChatEntity})
      : super(key: key);

  @override
  State<DocumentPreviewPage> createState() => _DocumentPreviewPageState();
}

class _DocumentPreviewPageState extends State<DocumentPreviewPage> {
  final TextEditingController captionController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBlackColor2,
          elevation: 0,
        ),
        backgroundColor: kBlackColor2,
        body: Stack(
          children: [
            Center(
              child: SizedBox(
                height: 400,
                child: Column(
                  children: [
                    SizedBox(
                      height: mq.height * 0.08,
                    ),
                    Icon(
                      widget.receiverId == "File"
                          ? CupertinoIcons.doc_chart
                          : CupertinoIcons.music_albums,
                      size: mq.height * 0.15,
                      color: kBackgroundColor,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.DocumentFilePath.name.split('.').first,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: kBlueLight2,
                        height: 1,
                        fontWeight: FontWeight.bold,
                        fontSize: mq.height * .04,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.DocumentFilePath.name.split('.').last,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: kBlueLight2,
                        height: 1.2,
                        fontWeight: FontWeight.bold,
                        fontSize: mq.width * .04,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${(widget.DocumentFilePath.size / 1024 / 1024).toStringAsFixed(2)} MB",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: kBackgroundColor,
                        height: 1.2,
                        fontSize: mq.width * .04,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              right: 0,
              left: 0,
              child: BottomFieldPreview(
                captionController: captionController,
                onSendButtonTaped: () {
                  if (widget.DocumentFilePath.path != null) {
                    BlocProvider.of<ChatCubit>(context).sendFileMessage(
                        type_message: widget.receiverId == "File" ? 5 : 4,
                        textMessageEntity: TextMessageEntity(
                            time: DateTime.now(),
                            messageId: 0,
                            url_madia: widget.DocumentFilePath.name,
                            isSend: false,
                            senderProfile:
                                widget.singleChatEntity.MyProfileImage,
                            senderId: widget.singleChatEntity.uid,
                            content: captionController.text != ""
                                ? captionController.text
                                : widget.receiverId == "File"
                                    ? "ملف"
                                    : "مقطع صوت",
                            senderName: widget.singleChatEntity.username,
                            channellId: widget.singleChatEntity.groupId,
                            type:
                                widget.receiverId == "File" ? "FILE" : "AUDIO"),
                        channelId: widget.singleChatEntity.groupId,
                        file: File(widget.DocumentFilePath.path!));
                    //to back to chat screen
                    int count = 0;
                    Navigator.of(context).popUntil((route) => count++ >= 2);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
