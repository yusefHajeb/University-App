import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:university/features/AllFeatures/presentation/bloc/SchedulBloc/schedul_bloc.dart';
import '../../../../core/color/app_color.dart';
import '../widget/Schedul/loaded_schedule.dart';
import 'application_page.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerWidget(context),
        backgroundColor: AppColors.backgroundPages,
        body: buildBody(context));
  }
}

Future<void> _onRefresh(BuildContext context) async {
  BlocProvider.of<ScheduleBloc>(context).add(RefreshScheduleEvent());
  return Future.value(Unit);
}

Widget buildBody(BuildContext context) {
  // List<String> getMonthDayList() {
  //   final now = DateTime.now();
  //   final dayesInMonth = DateTime(now.year, now.month + 1, 0).day;
  //   final monthDayList =
  //       List<String>.generate(dayesInMonth, (index) => (index + 1).toString());
  //   return monthDayList;
  // }

  // final List<String> weekDaysEn = ['Sat', 'San', 'Mon', 'Tue', 'Wed', 'Thu'];
  // final List<String> weekDaysAr = [
  //   'السبت',
  //   'الاحد',
  //   'الإثنين',
  //   'الثلاثاء',
  //   'الأربعاء',
  //   'الخميس'
  // ];
  // String getDay(int dayIndex) {
  //   final now = DateTime.now();
  //   final firstDay = DateTime(now.year, now.month, 1);
  //   final weekday = (firstDay.weekday + dayIndex - 1) % 7;
  //   return weekDaysEn[weekday];
  // }

  final day = DateFormat('dd').format(DateTime.now());
  return showSchedule(4, day);
  // String today = DateFormat('EEEE', 'ar')
  //     .format(DateTime(DateTime.now().year, DateTime.now().month, 12));
  // final hour = DateFormat('hh').format(DateTime.now());
  // return BlocConsumer<ScheduleBloc, ScheduleState>(
  //   listener: (BuildContext context, ScheduleState state) {},
  //   builder: (context, state) {
  //     if (state is LoadingSchedulState) {
  //       return const LoadingCircularProgress();
  //     } else if (state is LoadedSchedulState) {
  //       if (state.index == 0) {
  //         print("hour");

  //         print(day);
  //         print(today);
  //         return showSchedule(
  //             state.schedule, state.index == 0 ? null : state.index, day);
  //       } else {
  //         print("day");
  //         print(today);
  //         return showSchedule(
  //             state.schedule, state.index == 0 ? null : state.index, day);
  //       }

  //       // RefreshIndicator(
  //       //     onRefresh: () => _onRefresh(context),
  //       //     child: showSchedule(_days, state.schedule));
  //     } else if (state is ErrorSchedulState) {
  //       return Center(
  //         child: Column(
  //           children: [
  //             // Text("${state.message}"),
  //             ElevatedButton(
  //                 onPressed: () {
  //                   BlocProvider.of<ScheduleBloc>(context)
  //                       .add(const GetAllScheduleEvent(index: 0));
  //                 },
  //                 child: const Text("try again"))
  //           ],
  //         ),
  //       );
  //     } else {
  //       return Center(child: CircularProgressIndicator());
  //     }
  //   },
  // );

  // return _showSchedule(_days);
}


// print(c.time.toString());
// print(c.isHappening.toString());

