import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/chat/domain/entities/single_chat_entity.dart';
import 'package:university/chat/domain/entities/student_entity.dart';
import 'package:university/chat/presentation/cubit/group/group_cubit.dart';
import 'package:university/chat/presentation/cubit/user/user_cubit.dart';
import 'package:university/chat/presentation/pages/all_audio_recording.dart';
import 'package:university/chat/presentation/pages/all_document_chat_group.dart';
import 'package:university/chat/presentation/pages/all_media_chat_group.dart';
import 'package:university/chat/presentation/pages/all_student_in_batch.dart';
import 'package:university/chat/presentation/widgets/theme/style.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/features/AllFeatures/data/models/user_data.dart';
import 'package:university/features/AllFeatures/presentation/resources/assets_mananger.dart';

class ViewProfileScreen extends StatefulWidget {
  final SingleChatEntity chat;

  const ViewProfileScreen({Key? key, required this.chat}) : super(key: key);

  @override
  _ViewProfileScreenState createState() => _ViewProfileScreenState();
}

final List<String> categories = [
  'الزملاء',
  'الوسائط',
  'المستندات',
  'التسجيلات',
];

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  @override
  void initState() {
    // connectSocket();
    super.initState();
    BlocProvider.of<UserCubit>(context).getUsers(widget.chat.batch_id);
    BlocProvider.of<GroupCubit>(context).getGroups(widget.chat.batch_id);
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBlackColor2,
      //app bar
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          mq.height >= 550 ? mq.height / 1.65 : mq.height / 1.45,
        ),
        // Container Photo Home Pag..
        child: Container(
          height: 250,
          width: mq.width,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl:
                      "${Constants.linkImageRootImage}/${widget.chat.groupProfileImage}",
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Image.asset(ImageAssets.profile),
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 30,
                right: 7,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              const Positioned(
                top: 30,
                left: 16,
                child: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              Positioned(
                bottom: 60,
                right: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chat.groupName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: mq.width * 0.053,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<UserCubit, UserState>(
                      builder: (builder, state) {
                        if (state is UserLoaded) {
                          return Text(
                            "${state.users.length} أعضاء  ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: mq.width * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              Positioned(
                bottom: -2,
                left: 0,
                child: Container(
                  width: mq.width,
                  height: 60,
                  color: kBlackColor,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "الإشعارات",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: mq.width * .04,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "مفعلة",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: mq.width * .03,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 40,
                left: 30,
                child: CircleAvatar(
                  radius: mq.width * 0.06,
                  backgroundColor: kBlueLight2,
                  child: IconButton(
                    icon: Icon(
                      Icons.messenger,
                      size: mq.width * 0.053,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      //body
      body: DefaultTabController(
        length: categories.length,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              // padding: EdgeInsets.symmetric(horizontal: 5),
              width: mq.width,
              color: kBlackColor,
              child: TabBar(
                indicatorColor: kBlueLight2,
                isScrollable: true,
                tabs: categories.map((String category) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Tab(
                      text: category,
                    ),
                  );
                }).toList(),
                labelStyle: TextStyle(
                    fontSize: mq.width * .04,
                    fontFamily:
                        Theme.of(context).textTheme.bodyLarge!.fontFamily),
              ),
            ),
            Expanded(
              child: TabBarView(children: [
                AllStudentInBatch(
                    uid: StudentEntity(
                        t_id: int.parse(userDataModel().tId ?? "3"),
                        batch_id: int.parse(userDataModel().batchId ?? "4"),
                        std_image: userDataModel().image ?? "",
                        std_name: userDataModel().name ?? ""),
                    query: ""),
                AllMediaChatGroup(
                  uid: StudentEntity(
                      t_id: int.parse(userDataModel().tId ?? "3"),
                      batch_id: int.parse(userDataModel().batchId ?? "4"),
                      std_image: userDataModel().image ?? "",
                      std_name: userDataModel().name ?? ""),
                ),
                AllDocumentChatGroup(
                  uid: StudentEntity(
                      t_id: int.parse(userDataModel().tId ?? "3"),
                      batch_id: int.parse(userDataModel().batchId ?? "4"),
                      std_image: userDataModel().image ?? "",
                      std_name: userDataModel().name ?? ""),
                ),
                AllAudioChatGroup(
                  uid: StudentEntity(
                      t_id: int.parse(userDataModel().tId ?? "3"),
                      batch_id: int.parse(userDataModel().batchId ?? "4"),
                      std_image: userDataModel().image ?? "",
                      std_name: userDataModel().name ?? ""),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
