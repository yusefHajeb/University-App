import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/chat/domain/entities/single_chat_entity.dart';
import 'package:university/chat/domain/entities/text_messsage_entity.dart';
// import 'package:ngandika_app/presentation/bloc/message/bottom_chat/bottom_chat_cubit.dart';
// import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/bottom_chat/mic/recording_mic_widget.dart';
// import 'package:ngandika_app/utils/enums/message_type.dart';
import 'package:university/chat/presentation/cubit/bottom_chat/bottom_chat_cubit.dart';
import 'package:university/chat/presentation/cubit/chat/chat_cubit.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/bottom_chat/mic/recording_mic_widget.dart';
import 'package:path/path.dart';

class RecordingMic extends StatefulWidget {
  final SingleChatEntity singleChatEntity;

  const RecordingMic({Key? key, required this.singleChatEntity})
      : super(key: key);

  @override
  State<RecordingMic> createState() => _RecordingMicState();
}

class _RecordingMicState extends State<RecordingMic> {
  late final RecorderController recorderController;

  @override
  void initState() {
    super.initState();
    recorderController = RecorderController();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !context
          .watch<BottomChatCubit>()
          .isShowSendButton, //visible if isShowSendButton = false
      child: RecordingMicWidget(
        onVerticalScrollComplete: () {},
        onHorizontalScrollComplete: () {
          cancelRecord();
        },
        onLongPress: () {
          startRecording();
        },
        onLongPressCancel: () {
          stopRecording(context);
        },
        onSend: () {
          stopRecording(context);
        },
        onTapCancel: () {
          cancelRecord();
        },
      ),
    );
  }

  void startRecording() async {
    if (await recorderController.checkPermission()) {
      await recorderController.record();
    }
  }

  void cancelRecord() async {
    await recorderController.stop();
  }

  //when recording was stop it will send audio to firebase
  void stopRecording(BuildContext context) async {
    final path = await recorderController.stop();
    if (!mounted) return;
    BlocProvider.of<ChatCubit>(context).sendFileMessage(
      file: File(path!),
      type_message: 7,
      channelId: widget.singleChatEntity.groupId,
      textMessageEntity: new TextMessageEntity(
          isSend: false,
          messageId: 0,
          type: "RCO",
          time: DateTime.now(),
          url_madia: basename(path),
          channellId: widget.singleChatEntity.groupId,
          senderId: widget.singleChatEntity.uid,
          senderProfile: widget.singleChatEntity.MyProfileImage,
          senderName: widget.singleChatEntity.username,
          content: "تسجيل صوت"),
    );
  }

  @override
  void dispose() {
    super.dispose();
    recorderController.dispose();
  }
}
