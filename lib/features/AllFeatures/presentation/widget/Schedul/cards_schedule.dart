import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:university/core/fonts/app_fonts.dart';
import 'package:university/features/AllFeatures/domain/entites/schedule.dart';
import 'package:university/features/AllFeatures/presentation/widget/Schedul/green_done_icon.dart';
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
                print("you are in list show data");
                return AnimateInEffect(child: CardLetchers(data[index]));
              }),
            ),
          ),
        ),
      ),
    );
  }
}

Widget CardLetchers(Schedule schedule) {
  return Container(
    margin: EdgeInsets.only(
      top: 10,
    ),
    padding: EdgeInsets.all(10.0),
    height: 130,
    decoration: BoxDecorationStyles.headerTab,
    child: Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(18.0),
              child: Text(schedule.time.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.greyColor)),
            ),
            // Text("AM",
            //     style: TextStyle(
            //         fontWeight: FontWeight.bold, color: AppColors.greyColor)),
          ],
        ),
        AppSpaces.horizontalSpace10,
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          runSpacing: 1.0,
          direction: Axis.vertical,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.backgrounfContent,
                  ),
                  child: iconStatusLetchers(schedule.status ?? ""),
                ),
                Container(
                  height: 50,
                  width: 1,
                  color: AppColors.greyColor.withOpacity(0.5),
                ),
              ],
            )
          ],
        ),
        AppSpaces.horizontalSpace10,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppSpaces.verticalSpace20,
            Center(
              // padding: const EdgeInsets.only(right: 0),
              child: Text(
                schedule.courseName ?? "",
                style:
                    getFontNormal(15, FontWeightManager.bold, AppColors.white),
              ),
            ),
            AppSpaces.verticalSpace5,
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
    case "Canceled":
      return Icon(
        FontAwesomeIcons.xmark,
        color: AppColors.error,
      );
    case "Assured":
      return GreenDoneIcon(FontAwesomeIcons.circleCheck, AppColors.green);
    case "Pending":
      return GreenDoneIcon(
          FontAwesomeIcons.hourglass, Color.fromARGB(202, 185, 154, 41));
    // Icon(FontAwesomeIcons.circleQuestion, color: Colors.orange[300]);
    default:
      return GreenDoneIcon(
          FontAwesomeIcons.question, Color.fromARGB(202, 185, 154, 41));
  }
}
