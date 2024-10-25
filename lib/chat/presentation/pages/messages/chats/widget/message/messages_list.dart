import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/chat/domain/entities/single_chat_entity.dart';
import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/presentation/cubit/chat/chat_cubit.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/message/tag_chat_time.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/message_content_type/message_content_type.dart';
import 'package:university/chat/presentation/widgets/theme/style.dart';
import 'package:university/core/color/app_color.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/features/AllFeatures/presentation/resources/assets_mananger.dart';
import 'package:university/generated/Links.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:university/generated/helper/date_converter.dart';

class MessagesList extends StatefulWidget {
  final ChatLoaded messages;
  final SingleChatEntity singleChatEntity;
  const MessagesList(
      {super.key, required this.messages, required this.singleChatEntity});

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  ScrollController scrollController = ScrollController();
  List<TextMessageEntity> Mymessages = [];
  TextMessageEntity? textMessageEntity;
  FocusNode focusNode = FocusNode();
  bool show = false;
  final socket = IO.io('${Constants.serverIp}:3000', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });
  @override
  void initState() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    connectChanil();
    goToBottom();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void connectChanil() {
    print(widget.singleChatEntity.uid);
    socket.on("resend", (data) {
      textMessageEntity = TextMessageEntity(
          channellId: int.parse(data["channellId"]),
          content: data["content"],
          messageId: data["messageId"],
          senderId: data["senderId"],
          senderName: data["senderName"],
          senderProfile: data["senderProfile"],
          time: DateTime.parse(data["time"]),
          type: data["type_message"],
          url_madia: data["url_madia"]);
      if (textMessageEntity!.senderId != widget.singleChatEntity.uid) {
        print(widget.singleChatEntity.groupId.toString());
        if (textMessageEntity!.channellId == widget.singleChatEntity.groupId) {
          setState(() {
            Mymessages.add(textMessageEntity!);
          });
          print("Done Send from!" + widget.singleChatEntity.uid.toString());
        }
      }
    });

    socket.on("UpdatemessagefromStudent", (data) {
      print("UpdatemessagefromStudent");
      textMessageEntity = TextMessageEntity(
          channellId: int.parse(data["channellId"]),
          content: data["content"],
          messageId: data["messageId"],
          senderId: data["senderId"],
          senderName: data["senderName"],
          senderProfile: data["senderProfile"],
          time: DateTime.parse(data["time"]),
          type: data["type_message"],
          url_madia: data["url_madia"]);
      if (textMessageEntity!.senderId != widget.singleChatEntity.uid) {
        print(widget.singleChatEntity.groupId.toString());
        if (textMessageEntity!.channellId == widget.singleChatEntity.groupId) {
          int index = Mymessages.indexWhere(
              (message) => message.messageId == textMessageEntity!.messageId);
          if (index != -1) {
            setState(() {
              Mymessages[index] = textMessageEntity!;
            });
            print(Mymessages[index]);
          }
          print("Done Update from!" + widget.singleChatEntity.uid.toString());
        }
      }
    });
    socket.on("deletemessagefromStudent", (data) {
      textMessageEntity = TextMessageEntity(
          channellId: int.parse(data["channellId"]),
          content: data["content"],
          messageId: data["messageId"],
          senderId: data["senderId"],
          senderName: data["senderName"],
          senderProfile: data["senderProfile"],
          time: DateTime.parse(data["time"]),
          type: data["type_message"],
          url_madia: data["url_madia"]);
      if (textMessageEntity!.senderId != widget.singleChatEntity.uid) {
        print(widget.singleChatEntity.groupId.toString());
        if (textMessageEntity!.channellId == widget.singleChatEntity.groupId) {
          int index = Mymessages.indexWhere(
              (message) => message.messageId == textMessageEntity!.messageId);
          if (index != -1) {
            setState(() {
              Mymessages.removeAt(index);
            });
          }
          print("Done Delete from!" + widget.singleChatEntity.uid.toString());
        }
      }
    });

    socket.emit(
        "connected_student", {"std_id": '${widget.singleChatEntity.uid}'});
  }

  //this code is used to automatically scroll to the bottom of a scrollable widget, after the widget has finished rendering its content.
  void _scrollToBottom() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  void goToBottom() {
    for (int i = 1; i <= 8; i++) {
      Future.delayed(Duration(milliseconds: i * 50), () {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    goToBottom();
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ChatLoaded) {
          Mymessages = state.messages;
          return Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.backgroundPages,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: widget.messages.messages.isNotEmpty
                  ? ListView.builder(
                      controller: scrollController,
                      //shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: Mymessages.length,
                      itemBuilder: (_, index) {
                        //goToBottom();
                        final message = Mymessages[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (index == 0 ||
                                !DateConverter.getIsSameDay(
                                    message.time!, Mymessages[index - 1].time!))
                              TagChatTime(dateTime: message.time!),
                            if (message.senderId == widget.singleChatEntity.uid)
                              message_me(message: message),
                            if (message.senderId != widget.singleChatEntity.uid)
                              message_resive(message: message),
                          ],
                        );
                      },
                    )
                  : Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.speaker_notes_outlined,
                          size: 50,
                          color: greenColor,
                        ),
                        Text("مرحبا بك في الدردشة الجامعية"),
                      ],
                    )),
            ),
          );
        } else {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.speaker_notes_outlined,
                size: 50,
                color: greenColor,
              ),
              Text("مرحبا بك في الدردشة الجامعية"),
            ],
          ));
        }
      },
    );
  }
}

class message_resive extends StatelessWidget {
  const message_resive({
    Key? key,
    required this.message,
  }) : super(key: key);

  final TextMessageEntity message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5),
            height: 30,
            width: 30,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                child: CachedNetworkImage(
                  imageUrl:
                      "$Constants.linkImageRootImage/${message.senderProfile}",
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
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: MessageContentType(
              isSender: true,
              messageData: message,
            ),
          ),
        ],
      ),
    );
  }
}

class message_me extends StatelessWidget {
  const message_me({
    Key? key,
    required this.message,
  }) : super(key: key);

  final TextMessageEntity message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5),
            height: 30,
            width: 30,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                child: CachedNetworkImage(
                  imageUrl:
                      "${Constants.linkImageRootImage}/${message.senderProfile}",
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
          ),
          Padding(
              padding: const EdgeInsets.only(left: 27),
              child: MessageContentType(
                isSender: false,
                messageData: message,
              )),
        ],
      ),
    );
  }
}
