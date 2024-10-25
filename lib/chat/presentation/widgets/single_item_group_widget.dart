import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:university/chat/domain/entities/group_entity.dart';
import 'package:university/chat/presentation/cubit/count_new_message/count_new_message_cubit.dart';
import 'package:university/chat/presentation/widgets/profile_widget.dart';
import 'package:university/chat/presentation/widgets/theme/style.dart';
import 'package:university/core/color/app_color.dart';

class SingleItemGroupWidget extends StatelessWidget {
  final GroupEntity group;
  final VoidCallback onTap;

  const SingleItemGroupWidget(
      {Key? key, required this.group, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: profileWidget(imageUrl: group.groupProfileImage),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${group.groupName}",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            group.lastMessage == null || group.lastMessage == ""
                                ? "${group.groupName}"
                                : "${group.lastMessage}",
                            maxLines: 1,
                            style: TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      //   width: MediaQuery.of(context).size.width * .3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            group.lastMessage != null
                                ? DateFormat('hh:mm a')
                                    .format(group.TimelastMessage!)
                                : "",
                            // textAlign: ,
                            style: TextStyle(
                                fontSize: 12, color: AppColors.greyColor),
                          ),
                          SizedBox(
                              //height: 5,
                              ),
                          // _cubit.count_messag_no_seen != 0
                          //     ? CircleAvatar(
                          //         backgroundColor: greenColor,
                          //         radius: 10,
                          //         child: Text(
                          //           "${_cubit.count_messag_no_seen}",
                          //           style: TextStyle(
                          //               fontSize: 12, color: Colors.white),
                          //         ),
                          //       )
                          //     : SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60, right: 10),
              child: Divider(
                thickness: 1.50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
