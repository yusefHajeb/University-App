import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/chat/domain/entities/single_chat_entity.dart';
import 'package:university/chat/domain/entities/student_entity.dart';
import 'package:university/chat/presentation/cubit/group/group_cubit.dart';
import 'package:university/chat/presentation/cubit/user/user_cubit.dart';
import 'package:university/chat/presentation/widgets/single_item_group_widget.dart';
import 'package:university/core/color/app_color.dart';

import '../../../page_const.dart';

class GroupsPage extends StatelessWidget {
  final StudentEntity uid;
  final String? query;

  const GroupsPage({Key? key, required this.uid, this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPages,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //   Navigator.pushNamed(context, PageConst.createGroupPage,
          //       arguments: uid);
        },
        child: const Icon(Icons.group_add_sharp),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          if (userState is UserLoaded) {
            return BlocBuilder<GroupCubit, GroupState>(
              builder: (context, groupState) {
                if (groupState is GroupLoaded) {
                  final filteredGroups = groupState.groups
                      .where((group) =>
                          group.groupName.startsWith(query!) ||
                          group.groupName.startsWith(query!.toLowerCase()))
                      .toList();
                  return Container(
                    decoration: BoxDecoration(
                        color: AppColors.backgroundPages,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Column(
                      children: [
                        Expanded(
                            child: filteredGroups.isEmpty
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.group,
                                          size: 40,
                                          color: Colors.black.withOpacity(.4),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "No Group Created yet",
                                          style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(.2)),
                                        )
                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: filteredGroups.length,
                                    itemBuilder: (_, index) {
                                      return SingleItemGroupWidget(
                                        group: filteredGroups[index],
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, PageConst.singleChatPage,
                                              arguments: SingleChatEntity(
                                                batch_id: uid.batch_id,
                                                adminName: filteredGroups[index]
                                                    .adminName,
                                                MyProfileImage: uid.std_image,
                                                username: uid.std_name,
                                                groupId: filteredGroups[index]
                                                    .groupId,
                                                groupName: filteredGroups[index]
                                                    .groupName,
                                                uid: uid.t_id,
                                                groupProfileImage:
                                                    filteredGroups[index]
                                                        .groupProfileImage,
                                              ));
                                          // print(uid.t_id);
                                        },
                                      );
                                    },
                                  ))
                      ],
                    ),
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
