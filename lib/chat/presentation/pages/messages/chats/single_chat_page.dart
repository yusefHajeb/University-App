import 'dart:async';
import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:university/chat/domain/entities/group_entity.dart';
import 'package:university/chat/domain/entities/single_chat_entity.dart';
import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/presentation/cubit/chat/chat_cubit.dart';
import 'package:university/chat/presentation/cubit/count_new_message/count_new_message_cubit.dart';
import 'package:university/chat/presentation/cubit/group/group_cubit.dart';
import 'package:university/chat/presentation/pages/messages/chats/preview/image_preview_page.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/bottom_chat/custom_attachment_pop_up.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/bottom_chat/mic/recording_mic.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/message/messages_list.dart';
import 'package:university/chat/presentation/pages/view_profile_screen.dart';
import 'package:university/chat/presentation/widgets/profile_widget.dart';
import 'package:university/chat/presentation/widgets/theme/style.dart';
import 'package:university/core/color/app_color.dart';
import 'package:university/generated/Links.dart';

class SingleChatPage extends StatefulWidget {
  final SingleChatEntity singleChatEntity;
  const SingleChatPage({Key? key, required this.singleChatEntity})
      : super(key: key);

  @override
  _SingleChatPageState createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {
  String messageContent = "";
  TextEditingController _messageController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  bool _changeKeyboardType = false;
  int _menuIndex = 0;
  bool _showEmoji = false, _isUploading = false;

  @override
  void initState() {
    _messageController.addListener(() {
      setState(() {});
    });
    // BlocProvider.of<CountNewMessageCubit>(context).ChangeStateChat();
    BlocProvider.of<ChatCubit>(context)
        .getMessages(channelId: widget.singleChatEntity.groupId);
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        if (_showEmoji) {
          setState(() => _showEmoji = !_showEmoji);
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundPages,
        appBar: AppBar(
            backgroundColor: primaryColor,
            automaticallyImplyLeading: false,
            flexibleSpace: _appBar(),
            actions: [
              IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
            ]),
        body: BlocBuilder<ChatCubit, ChatState>(
          builder: (index, chatState) {
            if (chatState is ChatLoaded) {
              return Stack(
                children: [
                  Column(
                    children: [
                      MessagesList(
                          messages: chatState,
                          singleChatEntity: widget.singleChatEntity),
                      SizedBox(height: 5),
                      if (_isUploading)
                        const Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 20),
                                child:
                                    CircularProgressIndicator(strokeWidth: 2))),

                      //chat input filed
                      _chatInput(),
                      //show emojis on keyboard emoji button click & vice versa
                      if (_showEmoji)
                        SizedBox(
                          height: mq.height * .35,
                          child: EmojiPicker(
                              textEditingController: _messageController,
                              config: Config(
                                bgColor:
                                    const Color.fromARGB(255, 234, 248, 255),
                                columns: 8,
                                //emojiSizeMax: 32 * (Platform ? 1.30 : 1.0),
                              ),
                              onEmojiSelected: (emoji, category) {}),
                        )
                    ],
                  ),
                  _messageController.text.isEmpty && !_showEmoji
                      ? RecordingMic(singleChatEntity: widget.singleChatEntity)
                      : SizedBox()
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  // app bar widget
  Widget _appBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        ViewProfileScreen(chat: widget.singleChatEntity)));
          },
          child: Row(
            children: [
              //back button
              IconButton(
                  onPressed: () {
                    BlocProvider.of<CountNewMessageCubit>(context)
                        .ChangeStateChat();
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: textIconColor)),
              const SizedBox(width: 10),
              //user profile picture
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  child: profileWidget(
                      imageUrl: widget.singleChatEntity.groupProfileImage),
                ),
              ),

              //for adding some space
              const SizedBox(width: 20),
              //user name & last seen time
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //user name
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text("${widget.singleChatEntity.groupName}",
                        style: TextStyle(
                            fontSize: 18,
                            color: textIconColor,
                            fontWeight: FontWeight.w500)),
                  ),

                  //last seen time of user
                  Text("${widget.singleChatEntity.username}",
                      style: TextStyle(fontSize: 13, color: textIconColor)),
                ],
              )
            ],
          )),
    );
  }

  // // bottom chat input field
  Widget _chatInput() {
    Size mq = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: mq.height * .01, horizontal: mq.width * .025),
      child: Row(
        children: [
          //input field & buttons
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  //emoji button
                  IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() => _showEmoji = !_showEmoji);
                      },
                      icon: const Icon(Icons.emoji_emotions,
                          color: Colors.blueAccent, size: 25)),

                  Expanded(
                      child: TextField(
                    controller: _messageController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onTap: () {
                      if (_showEmoji) setState(() => _showEmoji = !_showEmoji);
                    },
                    decoration: const InputDecoration(
                        hintText: 'Type Something...',
                        hintStyle: TextStyle(color: Colors.blueAccent),
                        border: InputBorder.none),
                  )),

                  CustomAttachmentPopUp(
                      singleChatEntity: widget.singleChatEntity),
                  // IconButton(
                  //     onPressed: () async {

                  //     },
                  //     icon: const Icon(Icons.link,
                  //         color: Colors.blueAccent, size: 26)),

                  //pick image from gallery button
                  // IconButton(
                  //     onPressed: () async {
                  //       final ImagePi9999cker picker = ImagePicker();

                  //       // Picking multiple images
                  //       final List<XFile> images =
                  //           await picker.pickMultiImage(imageQuality: 70);

                  //       print(images.length);

                  //       // uploading & sending image one by one
                  //       for (var i in images) {
                  //         print('Image Path: ${i.path}');
                  //         setState(() => _isUploading = true);
                  //         //await APIs.sendChatImage(widget.user, File(i.path));
                  //         setState(() => _isUploading = false);
                  //       }
                  //     },
                  //     icon: const Icon(Icons.image,
                  //         color: Colors.blueAccent, size: 26)),

                  //take image from camera button
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        // Pick an image
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 70);
                        if (image != null) {
                          //log('Image Path: ${image.path}');
                          setState(() => _isUploading = true);
                          Navigator.pushNamed(
                              context, ImagePreviewPage.routeName,
                              arguments: ImagePreviewPage(
                                imageFilePath: File(image.path),
                                singleChatEntity: widget.singleChatEntity,
                              ));

                          setState(() => _isUploading = false);
                        }
                      },
                      icon: const Icon(Icons.camera_alt_rounded,
                          color: Colors.blueAccent, size: 26)),

                  //adding some space
                  SizedBox(width: mq.width * .02),
                ],
              ),
            ),
          ),

          //send message button
          Stack(
            children: [
              MaterialButton(
                onPressed: () {
                  if (_messageController.text.isNotEmpty) {
                    if (_messageController.text.isEmpty) {
                      //TODO:send voice message
                    } else {
                      BlocProvider.of<ChatCubit>(context).sendTextMessage(
                          textMessageEntity: TextMessageEntity(
                              time: DateTime.now(),
                              messageId: 0,
                              url_madia: "",
                              isSend: false,
                              senderProfile:
                                  widget.singleChatEntity.MyProfileImage,
                              senderId: widget.singleChatEntity.uid,
                              content: _messageController.text,
                              senderName: widget.singleChatEntity.username,
                              channellId: widget.singleChatEntity.groupId,
                              type: "TXET"),
                          channelId: widget.singleChatEntity.groupId);
                      BlocProvider.of<GroupCubit>(context)
                          .updateGroupLastMessageWhenSend(
                              groupEntity: GroupEntity(
                                  groupName: widget.singleChatEntity.groupName,
                                  groupProfileImage:
                                      widget.singleChatEntity.groupProfileImage,
                                  groupId: widget.singleChatEntity.groupId,
                                  lastMessage: _messageController.text,
                                  adminName: widget.singleChatEntity.adminName,
                                  TimelastMessage: DateTime.now()));

                      setState(() {
                        _messageController.clear();
                      });
                    }
                  }
                },
                minWidth: 0,
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, right: 10, left: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: greenColor,
                child: Icon(
                    _messageController.text.isEmpty ? Icons.mic : Icons.send,
                    color: Colors.white,
                    size: 28),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
