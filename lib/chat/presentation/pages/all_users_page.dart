import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/student_entity.dart';
import '../cubit/user/user_cubit.dart';
import '../widgets/single_item_user_widget.dart';
import '../widgets/theme/style.dart';

class AllUsersPage extends StatefulWidget {
  final StudentEntity uid;
  final String? query;

  const AllUsersPage({Key? key, required this.uid, this.query})
      : super(key: key);

  @override
  _AllUsersPageState createState() => _AllUsersPageState();
}

class _AllUsersPageState extends State<AllUsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
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
              decoration: BoxDecoration(
                  color: BodyColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  Expanded(
                      child: filteredUsers.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.group_add,
                                    size: 40,
                                    color: Colors.black.withOpacity(.4),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "No Users Found yet",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(.2)),
                                  )
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: filteredUsers.length,
                              itemBuilder: (_, index) {
                                return SingleItemStoriesStatusWidget(
                                  stud: filteredUsers[index],
                                  colorfont: kBlackColor,
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
