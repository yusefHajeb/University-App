import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/chat/domain/entities/student_entity.dart';
import 'package:university/chat/presentation/cubit/user/user_cubit.dart';
import 'package:university/chat/presentation/widgets/single_item_user_widget.dart';
import 'package:university/chat/presentation/widgets/theme/style.dart';

class AllStudentInBatch extends StatefulWidget {
  final StudentEntity uid;
  final String? query;

  const AllStudentInBatch({Key? key, required this.uid, this.query})
      : super(key: key);

  @override
  AllStudentInBatchState createState() => AllStudentInBatchState();
}

class AllStudentInBatchState extends State<AllStudentInBatch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          if (userState is UserLoaded) {
            print(widget.uid);
            final users = userState.users
                .where((element) =>
                    element.batch_id == widget.uid.batch_id &&
                    element.t_id != widget.uid.t_id)
                .toList();
            final filteredUsers = users
                .where((user) =>
                    user.std_name.startsWith(widget.query!) ||
                    user.std_name.startsWith(widget.query!.toLowerCase()))
                .toList();
            return Container(
              child: Column(
                children: [
                  Expanded(
                      child: filteredUsers.isEmpty
                          ? Center(
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
                                    "لا يوجد طلاب حاليا",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(.2)),
                                  )
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: filteredUsers.length,
                              itemBuilder: (_, index) {
                                return SingleItemStoriesStatusWidget(
                                  stud: filteredUsers[index],
                                  colorfont: White,
                                );
                              },
                            ))
                ],
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
