import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/chat/domain/entities/single_chat_entity.dart';
import 'package:university/chat/domain/entities/student_entity.dart';
import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/presentation/cubit/chat/chat_cubit.dart';
import 'package:university/chat/presentation/pages/messages/chats/preview/bottom_field_preview.dart';
import 'package:university/chat/presentation/pages/messages/chats/preview/preview_app_bar_icon.dart';
import 'package:path/path.dart';

// ignore: must_be_immutable
class ImagePreviewPage extends StatefulWidget {
  static const routeName = "image-preview";

  File imageFilePath;
  final String? receiverId;
  final StudentEntity? userData;
  final SingleChatEntity singleChatEntity;

  ImagePreviewPage(
      {Key? key,
      required this.imageFilePath,
      this.receiverId,
      this.userData,
      required this.singleChatEntity})
      : super(key: key);

  @override
  State<ImagePreviewPage> createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  final TextEditingController captionController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Image.file(
              File(widget.imageFilePath.path),
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
            ),
            PreviewAppBarIcon(
              isVideoPreview: false,
              onPressCropped: () {
                // cropImage(widget.imageFilePath.path).then((value) {
                //   String v = widget.imageFilePath.path;
                //   v = value!.path;
                //   //calling set state to rebuild
                //   setState(() {});
                // });
              },
            ),
            Positioned(
              bottom: 5,
              right: 0,
              left: 0,
              child: BottomFieldPreview(
                captionController: captionController,
                onSendButtonTaped: () {
                  if (widget.imageFilePath.path != null) {
                    BlocProvider.of<ChatCubit>(context).sendFileMessage(
                        type_message: 2,
                        textMessageEntity: TextMessageEntity(
                            time: DateTime.now(),
                            messageId: 0,
                            url_madia: basename(widget.imageFilePath.path),
                            isSend: false,
                            senderProfile:
                                widget.singleChatEntity.MyProfileImage,
                            senderId: widget.singleChatEntity.uid,
                            content: captionController.text != ""
                                ? captionController.text
                                : "صورة",
                            senderName: widget.singleChatEntity.username,
                            channellId: widget.singleChatEntity.groupId,
                            type: "IMAGE"),
                        channelId: widget.singleChatEntity.groupId,
                        file: widget.imageFilePath);
                    //to back to chat screen
                    int count = 0;
                    Navigator.of(context).popUntil((route) => count++ >= 2);
                  } else {}
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
