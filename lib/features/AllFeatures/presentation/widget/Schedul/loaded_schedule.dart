import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:university/features/AllFeatures/presentation/bloc/SchedulBloc/schedul_bloc.dart';

import '../../../../../core/color/app_color.dart';
import '../../../../../core/value/style_manager.dart';
import '../../../../../core/widget/bakground_dark.dart';
import '../../../../../core/widget/messaeg_widegt.dart';
import 'cards_schedule.dart';

showSchedule(int? changeDate, String foramtDateToDay) {
  // String foramtDateToDay() {
  //   return DateFormat('dd').format(DateTime.now());
  // }

  String foramtDateMonth() {
    // return DateFormat('mm').format(DateTime(DateTime.now().month));
    return "${DateFormat('MMMM', 'ar').format(DateTime.now())}  ${DateFormat('yyyy').format(DateTime.now())}";
  }

  List<String> getMonthDayList() {
    final now = DateTime.now();
    final dayesInMonth = DateTime(now.year, now.month, 0).day;
    final monthDayList =
        List<String>.generate(dayesInMonth, (index) => (index + 1).toString());
    return monthDayList;
  }

  print("getMonthDayList().length");

  print(getMonthDayList().length);

  print(DateTime.now());
  // ignore: unused_local_variable
  final List<String> weekDaysEn = [
    'Sun'
        'Mon',
    'Tue',
    'Wed',
    'Thu',
    'holeDay',
    'Sat',
  ];

  final List<String> weekDaysAr = [
    'الإثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
    'الأحد',
  ];
  String getDay(int dayIndex) {
    final now = DateTime.now();
    final firstDay = DateTime(now.year, now.month, 1);
    final weekday = (firstDay.weekday + dayIndex - 1) % 7;
    return weekDaysAr[weekday];
  }

  List<String> day = getMonthDayList();
  ScrollController _scrollController = ScrollController();
  void scrollToSelectedData(int selectedData) {
    // if (_scrollController.hasClients) {
    //   _scrollController.animateTo(selectedData * 50.0,
    //       duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    // }
    for (int i = 0; i < 8; i++) {
      Future.delayed(Duration(milliseconds: i * 50), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(selectedData * 50.0,
              duration: Duration(milliseconds: 300), curve: Curves.easeIn);
        }
      });
    }
  }

  //  final List<String> weekdays = DateFormat.E().narrow;
  return Container(
    child: Stack(
      children: [
        DarkRadialBackground(
          color: AppColors.backgroundPages,
          position: "top",
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: Text(
                          ' محاضرات اليوم',
                          style: getFontNormal(
                              12, FontWeight.bold, AppColors.greyColor),
                        ),
                      ),
                    ),
                  )
                ];
              },
              body: Padding(
                padding: EdgeInsets.all(1),
                child: BlocConsumer<ScheduleBloc, ScheduleState>(
                  listener: (context, index) {},
                  builder: (context, state) {
                    if (state is LoadedSchedulState) {
                      final now = DateTime.now();

                      final tomorrow = now.add(Duration(days: 1));

                      if ((state.day.toString() ==
                                  DateFormat('EEEE', 'ar').format(now) ||
                              state.day.toString() ==
                                  DateFormat('EEEE', 'ar').format(tomorrow)) &&
                          state.index >= 5) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          scrollToSelectedData(state.index);
                        });
                      }
                      return RefreshIndicator(
                        onRefresh: () async {
                          _onRefeishIndecator(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Builder(
                                      builder: (context) => IconButton(
                                        icon: new Icon(
                                          Icons.menu,
                                          color: AppColors.greyColor,
                                        ),
                                        onPressed: () =>
                                            Scaffold.of(context).openDrawer(),
                                      ),
                                    ),
                                    Text(
                                      foramtDateMonth(),
                                      style: getBlackStyleEn(
                                          color: AppColors.greyColor),
                                    ),
                                    const Spacer(),
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
                                    border: Border.all(
                                        width: 1.5,
                                        color: AppColors.backgrounfContent),
                                  ),
                                  child: ListView.builder(
                                    controller: _scrollController,
                                    shrinkWrap: true,
                                    itemExtent: 60.0,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: getMonthDayList().length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: InkWell(
                                          onTap: () {
                                            print(
                                                "=============$changeDate ===");
                                            state.day = getDay(index + 1);
                                            state.index = index + 1;

                                            if (state.index != 0) {
                                              print("index");
                                              print(
                                                  "${state.index}--- ${state.day}--------------------");
                                            }
                                            print("=================");
                                            print(
                                              getMonthDayList()[index],
                                            );
                                            print(state.schedule
                                                .where(
                                                  (element) =>
                                                      element.days ==
                                                      getMonthDayList()[index],
                                                )
                                                .toList());
                                            BlocProvider.of<ScheduleBloc>(
                                                    context)
                                                .add(SelectDayScheduleEvent(
                                                    index: state.index,
                                                    day: getDay(index)));
                                          },
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            width: 62,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(29),
                                              color: (state.index != 0
                                                  ? (state.index.toString() ==
                                                          day[index]
                                                      ? AppColors
                                                          .backgrounfContent
                                                      : Colors.blue
                                                          .withOpacity(0))
                                                  : (foramtDateToDay ==
                                                          day[index]
                                                      ? AppColors
                                                          .backgrounfContent
                                                      : Colors.blue
                                                          .withOpacity(0)))
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  getDay(index),
                                                  style: getFontNormal(
                                                      12,
                                                      FontWeight.bold,
                                                      (state.index != 0
                                                          ? (state.index
                                                                      .toString() ==
                                                                  day[index]
                                                              ? AppColors.white
                                                              : AppColors
                                                                  .greyColor)
                                                          : (foramtDateToDay ==
                                                                  day[index]
                                                              ? AppColors.white
                                                              : AppColors
                                                                  .greyColor))),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  getMonthDayList()[index],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: (state.index != 0
                                                          ? (state.index
                                                                      .toString() ==
                                                                  day[index]
                                                              ? AppColors
                                                                  .greyColor
                                                              : AppColors
                                                                  .backgroundAccentColor)
                                                          : (foramtDateToDay ==
                                                                  day[index]
                                                              ? AppColors
                                                                  .greyColor
                                                              : AppColors
                                                                  .backgroundAccentColor))),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                CardSchedule(
                                  check: state.check,
                                  state.schedule
                                      .where((element) =>
                                          element.days == state.day)
                                      .toList(), // .where(
                                  //     (element) => element.days == getDay(state.index - 1))
                                  // .toList())
                                ),
                                // Text(
                                //     "${state.schedule.where((element) => element.days == state.day)}")
                              ]),
                        ),
                      );
                    } else if (state is ErrorSchedulState) {
                      return MessageDisplayWidget(
                        message: state.message,
                      );
                    } else if (state is LoadingSchedulState) {
                      return Center(
                        child: Container(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              )),
        ),
      ],
    ),
  );
}

Future<void> _onRefeishIndecator(BuildContext context) async {
  context.read<ScheduleBloc>().add(RefreshScheduleEvent());
}
