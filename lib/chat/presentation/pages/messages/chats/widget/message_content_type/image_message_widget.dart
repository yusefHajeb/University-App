import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/presentation/cubit/chat/chat_cubit.dart';
import 'package:university/chat/presentation/cubit/group/group_cubit.dart';
import 'package:university/chat/presentation/cubit/image_cubit/image_cubit.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/message/dailog_for_edite_message.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/preview_message_content/image_message_preview.dart';
import 'package:university/chat/presentation/widgets/theme/style.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/features/AllFeatures/presentation/resources/assets_mananger.dart';
import 'package:university/generated/Links.dart';
import 'package:university/generated/helper/dialogs.dart';

import '../../../../../../../generated/Links.dart';

class ImageMessageWidget extends StatelessWidget {
  final TextMessageEntity messageData;
  final bool isSender;

  const ImageMessageWidget(
      {Key? key, required this.isSender, required this.messageData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onLongPress: () {
        _showBottomSheet(isSender, context);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.83,
                minWidth: 120,
              ),
              child: Container(
                child: Bubble(
                  color: isSender ? ColorBubbleSender : ColorBubbleMe,
                  nip: isSender ? BubbleNip.rightTop : BubbleNip.leftBottom,
                  shadowColor: Colors.black12,
                  elevation: 3,
                  radius: Radius.circular(25),
                  child: Stack(
                    children: [
                      Column(
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
                                      color: textPrimaryColor),
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: isSender
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 250,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  // color: Colors.blue,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, ImageMessagePreview.routeName,
                                        arguments: messageData);
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: BlocBuilder<ImageCubit, ImageStatus>(
                                      builder: (context, state) {
                                        return CachedNetworkImage(
                                          imageUrl:
                                              "${Constants.linkImageRootImageChat}/${messageData.url_madia!}",
                                          maxHeightDiskCache: 380,
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Container(
                                            height: 100,
                                            width: 200,
                                            margin: EdgeInsets.all(20),
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(ImageAssets.profile),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              messageData.content != "صورة" &&
                                      messageData.content != "صورة متحركة"
                                  ? Container(
                                      width: size.width - 150,
                                      child: Text(
                                        messageData.content!,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: Colors.black87,
                                          height: 1.2,
                                          fontSize: size.width * .04,
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                              SizedBox(height: 15),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Positioned(
                        bottom: 0,
                        left: 5,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 100,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                DateFormat('hh:mm a').format(messageData.time!),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black.withOpacity(.4),
                                ),
                              ),
                              isSender == false
                                  ? Icon(
                                      messageData.isSend == true
                                          ? Icons.done_all
                                          : Icons.access_time,
                                      color: Colors.blue,
                                      size: 15,
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // bottom sheet for modifying message details
  void _showBottomSheet(bool isMe, BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            children: [
              //black divider
              Container(
                height: 4,
                margin: EdgeInsets.symmetric(
                    vertical: mq.height * .015, horizontal: mq.width * .4),
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
              ),

              //copy option
              _OptionItem(
                  icon: const Icon(Icons.copy_all_rounded,
                      color: Colors.blue, size: 26),
                  name: 'Copy Text',
                  onTap: () async {
                    await Clipboard.setData(
                            ClipboardData(text: messageData.content.toString()))
                        .then((value) {
                      //for hiding bottom sheet
                      Navigator.pop(context);

                      Dialogs.showSnackbar(context, 'Text Copied!');
                    });
                  }),
              //save option
              _OptionItem(
                  icon: const Icon(Icons.download_rounded,
                      color: Colors.blue, size: 26),
                  name: 'Save Image',
                  onTap: () async {
                    // try {
                    //   log('Image Url: ${widget.message.msg}');
                    //   await GallerySaver.saveImage(widget.message.msg,
                    //           albumName: 'We Chat')
                    //       .then((success) {
                    //     //for hiding bottom sheet
                    //     Navigator.pop(context);
                    //     if (success != null && success) {
                    //       Dialogs.showSnackbar(
                    //           context, 'Image Successfully Saved!');
                    //     }
                    //   });
                    // } catch (e) {
                    //   log('ErrorWhileSavingImg: $e');
                    // }
                  }),

              //separator or divider
              if (isMe)
                Divider(
                  color: Colors.black54,
                  endIndent: mq.width * .04,
                  indent: mq.width * .04,
                ),

              //edit option
              if (!isMe)
                _OptionItem(
                    icon: const Icon(Icons.edit, color: Colors.blue, size: 26),
                    name: 'Edit Message',
                    onTap: () {
                      //for hiding bottom sheet
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (_) {
                            return MyShowWidgetToEdite(
                                textMessageEntity: messageData);
                          });
                    }),

              //delete option
              if (!isMe)
                _OptionItem(
                    icon: const Icon(Icons.delete_forever,
                        color: Colors.red, size: 26),
                    name: 'Delete Message',
                    onTap: () async {
                      BlocProvider.of<ChatCubit>(context)
                          .deleteTextMessage(textMessageEntity: messageData);
                      BlocProvider.of<GroupCubit>(context).refreshGroup();
                      Navigator.pop(context);
                    }),

              //separator or divider
              Divider(
                color: Colors.black54,
                endIndent: mq.width * .04,
                indent: mq.width * .04,
              ),

              //sent time
              _OptionItem(
                  icon: const Icon(Icons.done_all, color: Colors.blue),
                  name:
                      'Sent At: ${DateFormat('hh:mm a').format(messageData.time!)}',
                  onTap: () {}),
            ],
          );
        });
  }

  //dialog for updating message content
  void _showMessageUpdateDialog(BuildContext context) {
    String updatedMsg = messageData.content!;
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: const EdgeInsets.only(
                  left: 24, right: 24, top: 20, bottom: 10),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),

              //title
              title: Row(
                children: const [
                  Icon(
                    Icons.message,
                    color: Colors.blue,
                    size: 28,
                  ),
                  Text(' Update Message')
                ],
              ),

              //content
              content: TextFormField(
                initialValue: updatedMsg,
                maxLines: null,
                onChanged: (value) => updatedMsg = value,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),

              //actions
              actions: [
                //cancel button
                MaterialButton(
                    onPressed: () {
                      //hide alert dialog
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    )),

                //update button
                MaterialButton(
                    onPressed: () {
                      //hide alert dialog
                      // Navigator.pop(context);
                      // APIs.updateMessage(widget.message, updatedMsg);
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ))
              ],
            ));
  }
}

//custom options card (for copy, edit, delete, etc.)
class _OptionItem extends StatelessWidget {
  final Icon icon;
  final String name;
  final VoidCallback onTap;

  const _OptionItem(
      {required this.icon, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: EdgeInsets.only(
              left: mq.width * .05,
              top: mq.height * .015,
              bottom: mq.height * .015),
          child: Row(children: [
            icon,
            Flexible(
                child: Text('    $name',
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        letterSpacing: 0.5)))
          ]),
        ));
  }
}
