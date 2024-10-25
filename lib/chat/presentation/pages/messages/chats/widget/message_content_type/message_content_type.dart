import 'package:flutter/material.dart';
import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/message_content_type/audio_message_widget.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/message_content_type/decumen_message_widget.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/message_content_type/recording_message_widget.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/message_content_type/text_message_widget.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/message_content_type/video_message_widget.dart';

import 'image_message_widget.dart';

class MessageContentType extends StatelessWidget {
  final TextMessageEntity messageData;
  final bool isSender;

  const MessageContentType(
      {Key? key, required this.isSender, required this.messageData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (messageData.type) {
      case "TXET":
        return TextMessageWidget(
            message: messageData, isSender: isSender, isSend: true);
      case "IMAGE":
        return ImageMessageWidget(messageData: messageData, isSender: isSender);
      case "VEDIO":
        return VideoMessageWidget(messageData: messageData, isSender: isSender);
      case "GIF":
        return ImageMessageWidget(messageData: messageData, isSender: isSender);
      case "AUDIO":
        return AudioMessageWidget(messageData: messageData, isSender: isSender);
      case "RCO":
        return RecordingMessageWidget(
            messageData: messageData, isSender: isSender);

      case "FILE":
        return DocumentMessageWidget(
            messageData: messageData, isSender: isSender);
      default:
        return TextMessageWidget(
          message: messageData,
          isSender: isSender,
          isSend: true,
        );
    }
  }
}
