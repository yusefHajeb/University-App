import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:university/chat/domain/entities/student_entity.dart';
import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/presentation/cubit/chat/chat_cubit.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/preview_message_content/image_message_preview.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/preview_message_content/video_message_preview.dart';
import 'package:university/chat/presentation/widgets/theme/style.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/features/AllFeatures/presentation/resources/assets_mananger.dart';
import 'package:university/generated/Links.dart';
import 'package:university/generated/helper/date_converter.dart';
import 'package:university/generated/helper/time_extension.dart';
import 'package:university/chat/presentation/cubit/video_cubit/video_cubit_cubit.dart';
import 'package:http/http.dart' as http;

class AllAudioChatGroup extends StatefulWidget {
  final StudentEntity uid;

  const AllAudioChatGroup({Key? key, required this.uid}) : super(key: key);

  @override
  AllAudioChatGroupState createState() => AllAudioChatGroupState();
}

class AllAudioChatGroupState extends State<AllAudioChatGroup> {
  List<TextMessageEntity> listMessagefilter = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, userState) {
          if (userState is ChatLoaded) {
            print(widget.uid);
            var listMessage = userState.messages;
            listMessagefilter = [];
            for (var element in listMessage) {
              if (element.type == "AUDIO" || element.type == "ROC")
                listMessagefilter.add(element);
            }
            listMessagefilter = listMessagefilter.reversed.toList();
            return Container(
              child: Column(
                children: [
                  Expanded(
                      child: listMessagefilter.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.record_voice_over_sharp,
                                    size: 40,
                                    color: Colors.white.withOpacity(.4),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "لا توجد تسجيلات حاليا",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(.2)),
                                  )
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: listMessagefilter.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    my_show_media_audio(
                                      Messagemedia: listMessagefilter[index],
                                      TYPE:
                                          listMessagefilter[index].type == "ROC"
                                              ? 0
                                              : 1,
                                    ),
                                    if (index == 0 ||
                                        !DateConverter.getIsSameDay(
                                            listMessagefilter[index].time!,
                                            listMessagefilter[index - 1].time!))
                                      TagChatTimeMedia(
                                          dateTime:
                                              listMessagefilter[index].time!),
                                  ],
                                );
                              },
                            ))
                ],
              ),
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.white.withOpacity(.4),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "لا توجد ملفات حاليا",
                  style: TextStyle(color: Colors.white.withOpacity(.2)),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class my_show_media_audio extends StatefulWidget {
  my_show_media_audio(
      {Key? key, required this.Messagemedia, required this.TYPE})
      : super(key: key);

  final TextMessageEntity Messagemedia;
  final int TYPE;
  @override
  State<my_show_media_audio> createState() => my_show_media_audioState();
}

class my_show_media_audioState extends State<my_show_media_audio> {
  final AudioPlayer audioPlayer = AudioPlayer();

  Duration? newTiming;

  Duration? totalDuration;

  bool isPlaying = false;

  //initAudio is a function to initializes an AudioPlayer object for playing audio.
  void initAudio() {
    debugPrint("Audio Initialized");
    audioPlayer.play(
        UrlSource('$linkaudioRootChat/${widget.Messagemedia.url_madia!}'));
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
    return GestureDetector(
        onTap: () {},
        child: Container(
          height: 100,
          margin: const EdgeInsets.all(1),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.TYPE == 1 ? buildAvatar() : buildAvatarAudio(),
              GestureDetector(
                onTap: () {
                  if (isPlaying) {
                    audioPlayer.stop();
                    setState(() {
                      isPlaying = !isPlaying; // isPlaying = false
                    });
                  } else {
                    if (newTiming.toString() == "null") {
                      initAudio();
                    } else {
                      audioPlayer.resume();
                    }
                    setState(() {
                      isPlaying = !isPlaying; // isPlaying = false
                    });
                  }
                },
                child: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                  color: kGreyColor,
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
                          : newTiming!.inMilliseconds.toDouble(),
                      min: 0,
                      // max representing the total duration of the audio.
                      max: totalDuration == null
                          ? 20
                          : totalDuration!.inMilliseconds.toDouble(),

                      activeColor: kPrimaryColor,
                      inactiveColor: Colors.white38,
                      // The onChanged callback is called when the user interacts with the slider, and it seeks the audio to the specified position using the
                      // seekAudio() method with the updated value
                      onChanged: (value) async {
                        final position = Duration(milliseconds: value.toInt());

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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          style: TextStyle(color: kBlueLight2),
                        ),
                        Container(
                          width: 67,
                          child: Row(
                            children: [
                              Text(
                                DateFormat('hh:mm a')
                                    .format(widget.Messagemedia.time!),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(.4),
                                ),
                              ),
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
        ));
  }

  Widget buildAvatar() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5),
          height: 50,
          width: 50,
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              child: CachedNetworkImage(
                imageUrl:
                    "$Constants.linkImageRootImage/${widget.Messagemedia.senderProfile}",
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
        Positioned(
          right: -6,
          bottom: -3,
          child: Icon(Icons.mic, color: Colors.white),
        )
      ],
    );
  }

  Widget buildAvatarAudio() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5),
          height: 50,
          width: 50,
          child: CircleAvatar(
              backgroundColor: kPrimaryColor,
              child: Icon(
                CupertinoIcons.music_note_2,
              )),
        ),
      ],
    );
  }
}

class TagChatTimeMedia extends StatelessWidget {
  final DateTime dateTime;

  const TagChatTimeMedia({Key? key, required this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        color: kBlackColor2,
        // height: 20,
        width: mq.width,
        //margin: const EdgeInsets.all(5),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: Text(
          dateTime.getMonthAndYeer,
          style: TextStyle(
              color: kGreyColor,
              fontWeight: FontWeight.bold,
              fontSize: mq.width * 0.04),
        ),
      ),
    );
  }
}
