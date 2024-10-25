import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/presentation/cubit/chat/chat_cubit.dart';
import 'package:university/chat/presentation/cubit/group/group_cubit.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/message/dailog_for_edite_message.dart';
import 'package:university/chat/presentation/widgets/theme/style.dart';
import 'package:university/generated/helper/dialogs.dart';
import 'package:university/generated/helper/my_date_util.dart';

class TextMessageWidget extends StatefulWidget {
  final TextMessageEntity message;
  final bool isSender;
  final bool isSend;
  const TextMessageWidget(
      {Key? key,
      required this.isSender,
      required this.isSend,
      required this.message})
      : super(key: key);

  @override
  State<TextMessageWidget> createState() => _TextMessageWidgetState();
}

class _TextMessageWidgetState extends State<TextMessageWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onLongPress: () {
        showBottomSheet(widget.isSender);
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
                  color: widget.isSender ? ColorBubbleSender : ColorBubbleMe,
                  nip: widget.isSender
                      ? BubbleNip.rightTop
                      : BubbleNip.leftBottom,
                  shadowColor: Colors.black12,
                  elevation: 3,
                  radius: Radius.circular(16),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: widget.isSender
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          widget.isSender
                              ? Text(
                                  widget.message.senderName!.split(' ').first +
                                      " " +
                                      widget.message.senderName!
                                          .split(' ')
                                          .last,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: mq.width * 0.04,
                                      fontWeight: FontWeight.bold,
                                      color: textPrimaryColor),
                                )
                              : SizedBox(),
                          SizedBox(height: 2),
                          Text(
                            widget.message.content!,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.black87,
                              height: 1.2,
                              fontSize: size.width * .04,
                            ),
                          ),
                          SizedBox(
                              height: widget.message.content!.length < 50
                                  ? 18
                                  : 20),
                        ],
                      ),
                      SizedBox(height: 10),
                      Positioned(
                        bottom: -2,
                        left: 0,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 100,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                DateFormat('hh:mm a')
                                    .format(widget.message.time!),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black.withOpacity(.4),
                                ),
                              ),
                              widget.isSender == false
                                  ? Icon(
                                      widget.message.isSend == true
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

              //copy option
              _OptionItem(
                  icon: const Icon(Icons.copy_all_rounded,
                      color: Colors.blue, size: 26),
                  name: 'Copy Text',
                  onTap: () async {
                    await Clipboard.setData(
                            ClipboardData(text: widget.message.content ?? ""))
                        .then((value) {
                      //for hiding bottom sheet
                      Navigator.pop(context);
                      Dialogs.showSnackbar(context, 'Text Copied!');
                    });
                  }),

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
                                textMessageEntity: widget.message);
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
                          .deleteTextMessage(textMessageEntity: widget.message);
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
                      'Sent At: ${DateFormat('hh:mm a').format(widget.message.time!)}',
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
