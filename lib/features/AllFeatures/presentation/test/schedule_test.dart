import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/color/app_color.dart';
import '../../../../core/value/style_manager.dart';
import '../../../../core/widget/messaeg_widegt.dart';
import '../bloc/SchedulBloc/schedul_bloc.dart';
import '../widget/Schedul/cards_schedule.dart';

class ScheduleTest extends StatelessWidget {
  const ScheduleTest({super.key});

  @override
  Widget build(BuildContext context) {
    String foramtDateMonth() {
      // return DateFormat('mm').format(DateTime(DateTime.now().month));
      return "${DateFormat('MMMM').format(DateTime.now())}  ${DateFormat('yyyy').format(DateTime.now())}";
    }

    List<String> getMonthDayList() {
      final now = DateTime.now();
      final dayesInMonth = DateTime(now.year, now.month, 0).day;
      final monthDayList = List<String>.generate(
          dayesInMonth, (index) => (index + 1).toString());
      return monthDayList;
    }

    final List<String> weekDaysAr = [
      'الإثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
      'الاحد',
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
      for (int i = 0; i < 8; i++) {
        Future.delayed(Duration(milliseconds: i * 50), () {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(selectedData * 50.0,
                duration: Duration(milliseconds: 300), curve: Curves.easeIn);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundPages,
      body: Container(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
                  print(state.day);
                  print(state.index);
                  print(getDay(state.index));
                  if (state.index.toString() ==
                      DateFormat('dd').format(DateTime.now())) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      scrollToSelectedData(state.index);
                    });
                  }
                  print("state.schedule");
                  print(state.schedule);
                  return Text(
                      "${state.schedule.where((element) => element.days == state.day).toList()} ===");
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: <Widget>[
                      Row(
                        children: [
                          Text(
                            foramtDateMonth(),
                            style: getBlackStyleEn(color: AppColors.greyColor),
                          ),
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
                          border: Border.all(
                              width: 1.5, color: AppColors.backgrounfContent),
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
                                    state.day = getDay(index + 1);
                                    state.index = index + 1;

                                    if (state.index != 0) {
                                      print("index");
                                      print(
                                          "${state.index}-----------------------");
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
                                    BlocProvider.of<ScheduleBloc>(context).add(
                                        SelectDayScheduleEvent(
                                            index: state.index,
                                            day: getDay(index)));
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: 62,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(29),
                                      color: (state.index != 0
                                          ? (state.index.toString() ==
                                                  day[index]
                                              ? AppColors.backgrounfContent
                                              : Colors.blue.withOpacity(0))
                                          : (DateFormat('dd')
                                                      .format(DateTime.now()) ==
                                                  day[index]
                                              ? AppColors.backgrounfContent
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          getDay(index),
                                          style: getFontNormal(
                                              12,
                                              FontWeight.bold,
                                              (state.index != 0
                                                  ? (state.index.toString() ==
                                                          day[index]
                                                      ? AppColors.white
                                                      : AppColors.greyColor)
                                                  : (DateFormat('dd').format(
                                                              DateTime.now()) ==
                                                          day[index]
                                                      ? AppColors.white
                                                      : AppColors.greyColor))),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          getMonthDayList()[index],
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: (state.index != 0
                                                  ? (state.index.toString() ==
                                                          day[index]
                                                      ? AppColors.greyColor
                                                      : AppColors
                                                          .backgroundAccentColor)
                                                  : (DateFormat('dd').format(
                                                              DateTime.now()) ==
                                                          day[index]
                                                      ? AppColors.greyColor
                                                      : AppColors
                                                          .backgroundAccentColor))),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      CardSchedule(
                        state.schedule, // .where(
                        //     (element) => element.days == getDay(state.index - 1))
                        // .toList())
                      ),
                      Text(
                          "${state.schedule.where((element) => element.days == state.day)}")
                    ]),
                  );
                } else if (state is ErrorSchedulState) {
                  return MessageDisplayWidget(
                    message: state.message,
                  );
                } else if (state is LoadingSchedulState) {
                  return Center(
                    child: Container(),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
