import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:university/features/AllFeatures/presentation/bloc/SchedulBloc/schedul_bloc.dart';

import '../../../../../core/color/app_color.dart';
import '../../../../../core/value/style_manager.dart';
import '../../../domain/entites/schedule.dart';
import 'cards_schedule.dart';

showSchedule(List<Schedule> data, int? changeDate) {
  String foramtDateToDay() {
    return DateFormat('dd').format(DateTime.now());
  }

  String foramtDateMonth() {
    // return DateFormat('mm').format(DateTime(DateTime.now().month));
    return "${DateFormat('MMMM').format(DateTime.now())}  ${DateFormat('yyyy').format(DateTime.now())}";
  }

  List<String> getMonthDayList() {
    final now = DateTime.now();
    final dayesInMonth = DateTime(now.year, now.month + 1, 0).day;
    final monthDayList =
        List<String>.generate(dayesInMonth, (index) => (index + 1).toString());
    return monthDayList;
  }

  // ignore: unused_local_variable
  final List<String> weekDaysEn = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'holeDay',
    'Sat',
    'Sun'
  ];
  final List<String> weekDaysAr = [
    'السبت',
    'الاحد',
    'الإثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة'
  ];
  String getDay(int dayIndex) {
    final now = DateTime.now();
    final firstDay = DateTime(now.year, now.month, 1);
    final weekday = (firstDay.weekday + dayIndex - 1) % 7;
    return weekDaysAr[weekday];
  }

  // final dateTime = DateTime.now();
  // List<Schedule> response;
  // int _selectedDay = 2;
  // int _selectedRepeat = 0;
  // String _selectedHour = '13:30';
  // List<int> _selectedExteraCleaning = [];

  // final length = getMonthDayList();
  // int index = 0;
  List listda(int index) {
    return [getMonthDayList()[index], getDay(index)];
  }

  // for (int x in getMonthDayList()) {
  //   day = listda(x);
  // }

  List<String> day = getMonthDayList();

  //  final List<String> weekdays = DateFormat.E().narrow;
  return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Center(
                child: Text(
                  ' محاضرات اليوم',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ];
      },
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          Row(
            children: [
              Text(foramtDateMonth()),
              Spacer(),
              IconButton(
                padding: EdgeInsets.all(0),
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: Colors.grey.shade700,
                ),
              )
            ],
          ),
          Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // color: Colors.white,
              border: Border.all(width: 1.5, color: Colors.grey.shade200),
            ),
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: getMonthDayList().length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {},
                    child: InkWell(
                      onTap: () {
                        print("$changeDate ===");
                        BlocProvider.of<SchedulBloc>(context)
                            .add(GetAllScheduleEvent(index: index + 1));
                        // response = data
                        //     .where((element) =>
                        //         element.days == _days[index][1].toString())
                        //     .toList();
                        // String c = "Sat";
                        // bool fig = _days[changeDate ?? index][1] == "Sat";
                        // print(
                        //     "${_days[changeDate ?? index][1]} == $c  ===== figuar $fig");
                        // print(
                        //     "--------------------$fig---------\n   $changeDate  ------ ${_days[index][1]}");
                        // print("---- $response");
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: 62,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(29),
                          color: (changeDate != null
                              ? (changeDate.toString() == day[index]
                                  ? Colors.blue.shade100.withOpacity(0.5)
                                  : Colors.blue.withOpacity(0))
                              : (foramtDateToDay() == day[index]
                                  ? Colors.blue.shade100.withOpacity(0.5)
                                  : Colors.blue.withOpacity(0)))
                          // ? Colors.blue.shade100.withOpacity(0.5)
                          // : Colors.blue.withOpacity(0),
                          ,
                          // border: Border.all(
                          //   color: (changeDate != null
                          //       ? (changeDate.toString() == day[index]
                          //           ? Colors.blue.shade100.withOpacity(0.7)
                          //           : Colors.blue.withOpacity(0))
                          //       : (int.parse(foramtDateToDay()) == day
                          //           ? Colors.blue.shade100.withOpacity(0.7)
                          //           : Colors.blue.withOpacity(0))),
                          //   width: 1.5,
                          // ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              getDay(index),
                              style: getFontNormal(
                                  12, FontWeight.bold, AppColors.greyColor),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              getMonthDayList()[index],
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.kCardColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
          CardSchedule(data)
        ]),
      ));
}
