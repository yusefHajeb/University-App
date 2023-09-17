import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/color/app_color.dart';
import 'package:university/core/value/app_space.dart';
import 'package:university/features/AllFeatures/presentation/bloc/SchedulBloc/schedul_bloc.dart';
import '../../../../core/Utils/box_decoration.dart';
import '../../../../core/widget/animate_in_effect.dart';
import '../../../../core/widget/loading_widget.dart';
import '../../domain/entites/schedule.dart';
import '../widget/Schedul/cards_schedule.dart';
import '../widget/Schedul/loaded_schedule.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildBody(context));
  }
}

Future<void> _onRefresh(BuildContext context) async {
  BlocProvider.of<SchedulBloc>(context).add(RefreshScheduleEvent());
  // final x = BlocProvider.of<SchedulBloc>(context).getAllScheduleUsecase;
  // print("$x");
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

  int _selectedDay = 2;
  int _selectedRepeat = 0;
  String _selectedHour = '13:30';
  List<int> _selectedExteraCleaning = [];

  return BlocBuilder<SchedulBloc, SchedulState>(
    builder: (context, state) {
      // print(getMonthDayList());
      if (state is LoadingSchedulState) {
        return LoadingCircularProgress();
      } else if (state is LoadedSchedulState) {
        print("${state.index} ================");
        return showSchedule(
            state.schedule, state.index == 0 ? null : state.index);

        // RefreshIndicator(
        //     onRefresh: () => _onRefresh(context),
        //     child: showSchedule(_days, state.schedule));
      } else if (state is ErrorSchedulState) {
        return Center(
          child: Column(
            children: [
              Text("${state.message}"),
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<SchedulBloc>(context)
                        .add(GetAllScheduleEvent(index: 0));
                  },
                  child: Text("try again"))
            ],
          ),
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );

  // return _showSchedule(_days);
}


// print(c.time.toString());
// print(c.isHappening.toString());

