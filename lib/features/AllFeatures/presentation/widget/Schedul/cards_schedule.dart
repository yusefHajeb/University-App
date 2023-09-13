import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:university/features/AllFeatures/domain/entites/schedule.dart';
import '../../../../../core/Utils/box_decoration.dart';
import '../../../../../core/color/app_color.dart';
import '../../../../../core/value/app_space.dart';
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
        decoration: BoxDecorationStyles.fadingGlory,
        child: Padding(
          padding: EdgeInsets.all(1),
          child: DecoratedBox(
            decoration: BoxDecorationStyles.fadingGlory,
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: data.length,
              itemBuilder: ((context, index) {
                return AnimateInEffect(child: Card2(data[index]));
              }),
              separatorBuilder: (BuildContext context, int index) {
                return AppSpaces.verticalSpace20;
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CardShedeulWidget extends StatelessWidget {
  const CardShedeulWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecorationStyles.fadingInnerDecor,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 10,
        child: Stack(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Positioned(
              width: 30,
              top: 9,
              right: 10,
              child: Container(
                width: 30,
                height: 60,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(33, 150, 243, 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Column(
                  children: [Icon(Icons.timelapse_outlined), Text("8:10")],
                ),
              ),
            ),
            Container(
              height: 200,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  color: Colors.greenAccent),
            ),
            Positioned(
                top: 10,
                right: 200,
                child: Icon(
                  Icons.check_box,
                  size: 40,
                  color: Colors.green,
                )),
            Positioned.fill(
                top: 80,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.bookOpen),
                            AppSpaces.horizontalSpace20,
                            Text(
                              "OOP ",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          children: [
                            Icon(Icons.person_outline_sharp),
                            AppSpaces.horizontalSpace20,
                            Text(
                              "فهد الاغبري",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.locationDot),
                            AppSpaces.horizontalSpace20,
                            Text(
                              "الرازي",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

Widget Card2(Schedule schedule) {
  return Container(
    padding: EdgeInsets.all(10.0),
    height: 150,
    decoration: BoxDecorationStyles.fadingInnerDecor,
    child: Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(schedule.time.toString(),
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text("AM",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: AppColors.greyColor)),
          ],
        ),
        AppSpaces.horizontalSpace10,
        Column(
          children: [
            Icon(
              FontAwesomeIcons.circleCheck,
              color: AppColors.greyColor,
            ),
            Container(
              height: 100,
              width: 1,
              color: AppColors.greyColor.withOpacity(0.5),
            ),
          ],
        ),
        AppSpaces.horizontalSpace10,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(schedule.coures ?? ""),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: AppColors.greyColor,
                  size: 20,
                ),
                AppSpaces.horizontalSpace10,
                Text(schedule.classroom ?? "",
                    style: TextStyle(color: AppColors.greyColor, fontSize: 13)),
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
                Text(schedule.instructor ?? "",
                    style: TextStyle(color: AppColors.greyColor, fontSize: 13)),
              ],
            )
          ],
        )
      ],
    ),
  );
}
