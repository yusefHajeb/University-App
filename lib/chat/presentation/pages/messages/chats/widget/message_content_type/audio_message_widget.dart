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

class AudioMessageWidget extends StatefulWidget {
  final TextMessageEntity messageData;
  final bool isSender;

  const AudioMessageWidget(
      {Key? key, required this.messageData, required this.isSender})
      : super(key: key);

  @override
  State<AudioMessageWidget> createState() => _AudioMessageWidgetState();
}

class _AudioMessageWidgetState extends State<AudioMessageWidget> {
  final AudioPlayer audioPlayer = AudioPlayer();
  Duration? newTiming;
  Duration? totalDuration;
  bool isPlaying = false;

  //initAudio is a function to initializes an AudioPlayer object for playing audio.
  void initAudio() {
    debugPrint("Audio Initialized");
    audioPlayer
        .play(UrlSource('$linkaudioRootChat/${widget.messageData.url_madia!}'));
    //// get total duration of the audio file
    audioPlayer.getDuration().then((value) {
      debugPrint(value.toString());
    });
    //this used to update the UI with the current playback position.
    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        newTiming = event;
      });
    });
    //this used to update the UI with the total duration of the audio file.
    audioPlayer.onDurationChanged.listen((updatedDuration) {
      setState(() {
        totalDuration = updatedDuration;
      });
    });
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
  }

  void seekAudio(Duration durationToSeek) {
    audioPlayer.seek(durationToSeek);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onLongPress: () {
            showBottomSheet(widget.isSender);
          },
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              buildAvatar(),
                              GestureDetector(
                                onTap: () {
                                  if (isPlaying) {
                                    audioPlayer.stop();
                                    setState(() {
                                      isPlaying =
                                          !isPlaying; // isPlaying = false
                                    });
                                  } else {
                                    if (newTiming.toString() == "null") {
                                      initAudio();
                                    } else {
                                      audioPlayer.resume();
                                    }
                                    setState(() {
                                      isPlaying =
                                          !isPlaying; // isPlaying = false
                                    });
                                  }
                                },
                                child: Icon(
                                  isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow_rounded,
                                  color: kBlackColor,
                                  size: 40,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    //The Slider widget is used to display the progress of the audio playback.
                                    Slider(
                                      //value representing the current position of the audio.
                                      value: newTiming == null
                                          ? 0
                                          : newTiming!.inMilliseconds
                                              .toDouble(),
                                      min: 0,
                                      // max representing the total duration of the audio.
                                      max: totalDuration == null
                                          ? 20
                                          : totalDuration!.inMilliseconds
                                              .toDouble(),

                                      activeColor: widget.isSender
                                          ? kOrangeColor
                                          : kPrimaryColor,
                                      inactiveColor: Colors.black38,
                                      // The onChanged callback is called when the user interacts with the slider, and it seeks the audio to the specified position using the
                                      // seekAudio() method with the updated value
                                      onChanged: (value) async {
                                        final position = Duration(
                                            milliseconds: value.toInt());

                                        await audioPlayer.seek(position);
                                        setState(() {
                                          newTiming = position;
                                          // seekAudio(Duration(
                                          //     milliseconds: value.toInt()));
                                        });
                                      },
                                    ),

                                    // to show duration and time sent message
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        //duration
                                        Text(
                                          (newTiming.toString() == "null")
                                              ? "0:00"
                                              : newTiming
                                                  .toString()
                                                  .split('.')
                                                  .first
                                                  .substring(3),
                                          style: TextStyle(
                                              color: widget.isSender
                                                  ? kBlackColor
                                                  : kBlackColor),
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
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
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

  Widget buildAvatar() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5),
          height: 50,
          width: 50,
          child: CircleAvatar(
              backgroundColor: widget.isSender ? kOrangeColor : kPrimaryColor,
              child: Icon(
                CupertinoIcons.music_note_2,
              )),
        ),
      ],
    );
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
