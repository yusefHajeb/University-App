import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:university/features/AllFeatures/domain/entites/schedule.dart';
import '../../../../../core/Utils/box_decoration.dart';
import '../../../../../core/color/app_color.dart';
import '../../../../../core/value/app_space.dart';
import '../../../../../core/value/style_manager.dart';
import '../../../../../core/widget/animate_in_effect.dart';

class CardSchedule extends StatelessWidget {
  final List<Schedule> data;
  CardSchedule(
    this.data, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        // decoration: BoxDecoration(color: AppColors.white),
        child: Padding(
          padding: EdgeInsets.all(0),
          child: DecoratedBox(
            decoration: BoxDecoration(color: AppColors.backgroundPages),
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: data.length,
              separatorBuilder: (BuildContext context, int index) {
                return AppSpaces.verticalSpace10;
              },
              itemBuilder: ((context, index) {
                print("======${data[index]}");
                return AnimateInEffect(child: Card2(data[index]));
              }),
            ),
          ),
        ),
      ),
    );
  }
}

// class CardShedeulWidget extends StatelessWidget {
//   const CardShedeulWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 200,
//       decoration: BoxDecorationStyles.fadingInnerDecor,
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         elevation: 10,
//         child: Stack(
//           // crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Positioned(
//               width: 30,
//               top: 9,
//               right: 10,
//               child: Container(
//                 width: 30,
//                 height: 60,
//                 decoration: BoxDecoration(
//                   color: Color.fromRGBO(33, 150, 243, 0.5),
//                   borderRadius: BorderRadius.all(Radius.circular(30)),
//                 ),
//                 child: Column(
//                   children: [Icon(Icons.timelapse_outlined), Text("8:10")],
//                 ),
//               ),
//             ),
//             Container(
//               height: 200,
//               width: 30,
//               decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       bottomLeft: Radius.circular(10)),
//                   color: Colors.greenAccent),
//             ),
//             const Positioned(
//               top: 10,
//               right: 200,
//               child: Icon(
//                 Icons.check_box,
//                 size: 40,
//                 color: Colors.green,
//               ),
//             ),
//             Positioned.fill(
//               top: 80,
//               child: Align(
//                 alignment: Alignment.center,
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(3.0),
//                       child: Row(
//                         children: [
//                           Icon(FontAwesomeIcons.bookOpen),
//                           AppSpaces.horizontalSpace20,
//                           Text(
//                             "OOP ",
//                             style: Theme.of(context).textTheme.subtitle1,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(3.0),
//                       child: Row(
//                         children: [
//                           const Icon(Icons.person_outline_sharp),
//                           AppSpaces.horizontalSpace20,
//                           Text(
//                             "فهد الاغبري",
//                             style: Theme.of(context).textTheme.subtitle1,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(3.0),
//                       child: Row(
//                         children: [
//                           const Icon(FontAwesomeIcons.locationDot),
//                           AppSpaces.horizontalSpace20,
//                           Text(
//                             "الرازي",
//                             style: Theme.of(context).textTheme.subtitle1,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

Widget Card2(Schedule schedule) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    padding: EdgeInsets.all(10.0),
    height: 130,
    decoration: BoxDecorationStyles.testStyle,
    child: Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(schedule.time.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: AppColors.greyColor)),
            // Text("AM",
            //     style: TextStyle(
            //         fontWeight: FontWeight.bold, color: AppColors.greyColor)),
          ],
        ),
        AppSpaces.horizontalSpace10,
        Column(
          children: [
            iconStatusLetchers(schedule.status ?? ""),
            Container(
              height: 80,
              width: 1,
              color: AppColors.greyColor.withOpacity(0.5),
            ),
          ],
        ),
        AppSpaces.horizontalSpace10,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppSpaces.verticalSpace20,
            Text(
              schedule.courseName ?? "",
              style: getFontNormal(13, FontWeight.w600, AppColors.white),
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: AppColors.greyColor,
                  size: 20,
                ),
                AppSpaces.horizontalSpace10,
                Text(schedule.classroom ?? "",
                    style: getFontNormal(
                        12, FontWeight.normal, AppColors.greyColor)),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.person_outline,
                  color: AppColors.greyColor,
                  size: 20,
                ),
                AppSpaces.horizontalSpace10,
                Text(schedule.instructorName ?? "",
                    style: getFontNormal(
                        12, FontWeight.normal, AppColors.greyColor)),
              ],
            )
          ],
        )
      ],
    ),
  );
}

Widget iconStatusLetchers(String status) {
  switch (status) {
    case "ملغي":
      return Icon(
        FontAwesomeIcons.cancel,
        color: AppColors.error,
      );
    case "مؤكدة":
      return Icon(FontAwesomeIcons.circleCheck, color: AppColors.green);
    case "قيد الإنتظار":
      return Icon(FontAwesomeIcons.circleQuestion, color: Colors.orange[300]);
    default:
      return Icon(FontAwesomeIcons.question, color: AppColors.greyColor);
  }
}
