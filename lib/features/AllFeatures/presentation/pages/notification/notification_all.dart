import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:university/core/Utils/box_decoration.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/core/value/app_space.dart';
import 'package:university/core/widget/flutter_toast.dart';
import 'package:university/features/AllFeatures/domain/entites/schedule.dart';
import 'package:university/features/AllFeatures/presentation/bloc/notifications/notefications_bloc.dart';
import '../../../../../core/color/app_color.dart';
import '../../../../../core/value/style_manager.dart';
import '../../../../../core/widget/bakground_dark.dart';
import '../../../../../core/widget/dummy/notification_widget.dart';
import '../../widget/Schedul/cards_schedule.dart';
// import '../../bloc/book_favorite_bloc/books_favorite_bloc.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});
  void shareFile(String filePath) async {
    print("shareFile");
    // print(filePath);
    String path = File(filePath).path;
    print(path);
    final result = await Share.shareXFiles([XFile(filePath)],
        subject: "ملف من تطبيق جامعتي");

    if (result.status == ShareResultStatus.success) {
      toastInfo(msg: "تم ارسال الكتاب بنجاح");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: double.infinity,
        height: appSize(context).height,
        color: AppColors.backgroundPages,
        child: Stack(
          children: [
            DarkRadialBackground(
              color: AppColors.backgroundPages,
              position: "topLeft",
            ),
            Padding(
                padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                child: Column(children: [
                  AppSpaces.verticalSpace20,
                  Text(
                    "الاشعارات",
                    style: getFontNormal(
                      17,
                      FontWeight.bold,
                      AppColors.bottomHeaderColor,
                    ),
                  ),
                  AppSpaces.verticalSpace20,
                  BlocBuilder<NotificationsBloc, NotificationsState>(
                    builder: (context, state) {
                      if (state is LoadingNotifications) {
                        print("LoadingNotifications");
                        return Container(
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (state is LoadedNotifications) {
                        print("LoadedNotifications");

                        return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.notifications.length,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 10,
                                // child: Divider(
                                //   color: AppColors.greyColor,
                                //   height: 0.8,
                                // ),
                              );
                            },
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecorationStyles.headerTab,
                                child: NotificationCard(
                                  date: "${state.notifications[index].date}",
                                  // imageBackground: "#181a1f",
                                  mentioned:
                                      state.notifications[index].note ?? false,
                                  mention: "8",
                                  newsImage: Constants.imageNews +
                                      state.notifications[index].image
                                          .toString(),
                                  imageBackground: "B0FFE1",
                                  // image: Constants.imageRoute +
                                  //     userDataModel().image.toString(),
                                  message:
                                      " ${state.notifications[index].content}",
                                  read: false,
                                  userOnline: true,
                                  userName:
                                      "${state.notifications[index].title}",

                                  // onTap: () {
                                  //   shareFile(
                                  // state.notifications[index].file.toString());
                                  // },
                                ),
                              );
                            });
                      } else if (state is ErrorNotifications) {
                        return Container(
                          child: Text(state.errorMessage),
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                  // NotificationCard(
                  //   date: "${DateTime.now().day} / ${DateTime.now().month}",
                  //   // imageBackground: "#181a1f",
                  //   mentioned: false,
                  //   mention: "8",
                  //   image:
                  //       Constants.imageRoute + userDataModel().image.toString(),
                  //   message: "schedul.note ?? " "",
                  //   read: false,
                  //   userOnline: true,
                  //   userName: "${userDataModel().name}",
                  // ),
                  AppSpaces.verticalSpace10,
                ]))
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class NoteLetcher extends StatelessWidget {
  Schedule schedul;
  bool showStyleOld;
  NoteLetcher({super.key, required this.schedul, required this.showStyleOld});

  @override
  Widget build(BuildContext context) {
    print("Constants.imageInstractor  schedul.imageInstractor.toString()");
    print(Constants.imageInstractor + schedul.imageInstractor.toString());
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecorationStyles.headerTab,
      child: Column(
        children: [
          // AppSpaces.verticalSpace10,
          CardLetchers(
              schedul,
              // schedul.date != ""
              //     ? int.parse(schedul.date!
              //                 .split("-")[schedul.date!.split("-").length]) <
              //             DateTime.now().day
              //         ? false
              //         : true
              //     : false
              //     ),
              showStyleOld),
          schedul.note != ""
              ? NotificationCard(
                  date: "${schedul.days} / ${DateTime.now().month}",
                  // imageBackground: "#181a1f",
                  mentioned: false,
                  mention: "8",
                  image: Constants.imageInstractor +
                      schedul.imageInstractor.toString(),
                  message: schedul.note ?? "",
                  read: !showStyleOld,
                  userOnline: showStyleOld,
                  userName: "${schedul.instructorName}",
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
