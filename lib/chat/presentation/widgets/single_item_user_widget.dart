import 'package:flutter/material.dart';
import 'package:university/chat/domain/entities/student_entity.dart';
import 'package:university/chat/presentation/widgets/profile_dialog.dart';
import 'package:university/chat/presentation/widgets/profile_widget.dart';
import 'package:university/chat/presentation/widgets/theme/style.dart';

class SingleItemStoriesStatusWidget extends StatelessWidget {
  final StudentEntity stud;
  final colorfont;
  const SingleItemStoriesStatusWidget(
      {Key? key, required this.stud, required this.colorfont})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ProfileDialog(
              user: stud,
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, right: 15, left: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                          border: Border.all(color: White, width: 0.9),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: profileWidget(imageUrl: stud.std_image),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${stud.std_name}",
                            style: TextStyle(
                                fontSize: mq.width * 0.04,
                                fontWeight: FontWeight.w500,
                                color: colorfont),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                              stud.status == null || stud.status == ""
                                  ? "Hi! I'm using this app"
                                  : "${stud.status}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: mq.width * 0.03,
                                  fontWeight: FontWeight.w500,
                                  color: colorfont)),
                        ],
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.circle,
                  color: stud.isOnline == 1 ? Colors.blue : Colors.black45,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Divider(
                thickness: 0.2,
                color: kBlueLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
