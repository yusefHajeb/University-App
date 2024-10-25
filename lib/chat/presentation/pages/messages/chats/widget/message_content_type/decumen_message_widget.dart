import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/presentation/cubit/chat/chat_cubit.dart';
import 'package:university/chat/presentation/cubit/group/group_cubit.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/message/dailog_for_edite_message.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/message_content_type/time_sent_message_widget.dart';
import 'package:university/chat/presentation/widgets/theme/style.dart';
import 'package:university/generated/Links.dart';
import 'package:university/generated/helper/dialogs.dart';

class DocumentMessageWidget extends StatefulWidget {
  final TextMessageEntity messageData;
  final bool isSender;

  const DocumentMessageWidget(
      {Key? key, required this.messageData, required this.isSender})
      : super(key: key);

  @override
  State<DocumentMessageWidget> createState() => DocumentMessageWidgetState();
}

class DocumentMessageWidgetState extends State<DocumentMessageWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onLongPress: () {
            showBottomSheet(widget.isSender);
          },
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: widget.isSender
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.83,
                  ),
                  child: Container(
                    child: Bubble(
                      color:
                          widget.isSender ? ColorBubbleSender : ColorBubbleMe,
                      nip: widget.isSender
                          ? BubbleNip.rightTop
                          : BubbleNip.leftBottom,
                      shadowColor: Colors.black12,
                      elevation: 3,
                      radius: Radius.circular(16),
                      child: Column(
                        crossAxisAlignment: widget.isSender
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          widget.isSender
                              ? Text(
                                  widget.messageData.senderName!
                                          .split(' ')
                                          .first +
                                      " " +
                                      widget.messageData.senderName!
                                          .split(' ')
                                          .last,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: size.width * .04,
                                      fontWeight: FontWeight.bold,
                                      color: textPrimaryColor),
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                height: 50,
                                width: 50,
                                child: Icon(
                                  CupertinoIcons.doc_circle_fill,
                                  size: 50,
                                  color: widget.isSender
                                      ? kBlueLight2
                                      : kBlackColor,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      widget.messageData.url_madia!
                                          .split('.')
                                          .first,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        height: 1.2,
                                        fontSize: size.width * .03,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Text(
                                            widget.messageData.url_madia!
                                                .split('.')
                                                .last,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: Colors.black87,
                                              height: 1.2,
                                              fontSize: size.width * .04,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 67,
                                          child: Row(
                                            children: [
                                              Text(
                                                DateFormat('hh:mm a').format(
                                                    widget.messageData.time!),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black
                                                      .withOpacity(.4),
                                                ),
                                              ),
                                              widget.isSender == false
                                                  ? Icon(
                                                      widget.messageData
                                                                  .isSend ==
                                                              true
                                                          ? Icons.done_all
                                                          : Icons.access_time,
                                                      color: Colors.blue,
                                                      size: 15,
                                                    )
                                                  : SizedBox(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void showBottomSheet(bool isMe) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            children: [
              Container(
                height: 4,
                margin: EdgeInsets.symmetric(
                    vertical: mq.height * .015, horizontal: mq.width * .4),
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
              ),

              //delete option
              if (!isMe)
                _OptionItem(
                    icon: const Icon(Icons.delete_forever,
                        color: Colors.red, size: 26),
                    name: 'Delete Message',
                    onTap: () async {
                      BlocProvider.of<ChatCubit>(context).deleteTextMessage(
                          textMessageEntity: widget.messageData);
                      BlocProvider.of<GroupCubit>(context).refreshGroup();
                      Navigator.pop(context);
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(content: Text('تم حذف الرسالة!')));
                      // Dialogs.showSnackbar(context, 'تم حذف الرسالة!');
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
                      'Sent At: ${DateFormat('hh:mm a').format(widget.messageData.time!)}',
                  onTap: () {}),
            ],
          );
        });
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
              right: mq.width * .04,
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
