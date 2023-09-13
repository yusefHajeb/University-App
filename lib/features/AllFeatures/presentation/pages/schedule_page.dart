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
    return Scaffold(body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    final List<dynamic> _days = [
      [1, 'Fri'],
      [2, 'Sat'],
      [3, 'Sun'],
      [4, 'Mon'],
      [5, 'Tue'],
      [6, 'Wed'],
      [7, 'Thu'],
      [8, 'Fri'],
      [9, 'Sat'],
      [10, 'Sun'],
      [11, 'Mon'],
      [12, 'Tue'],
      [13, 'Wed'],
      [14, 'Thu'],
      [15, 'Fri'],
      [16, 'Sat'],
      [17, 'Sun'],
      [18, 'Mon'],
      [19, 'Tue'],
      [20, 'Wed'],
      [21, 'Thu'],
      [22, 'Fri'],
      [23, 'Sat'],
      [24, 'Sun'],
      [25, 'Mon'],
      [26, 'Tue'],
      [27, 'Wed'],
      [28, 'Thu'],
      [29, 'Fri'],
      [30, 'Sat'],
      [31, 'Sun']
    ];
    int _selectedDay = 2;
    int _selectedRepeat = 0;
    String _selectedHour = '13:30';
    List<int> _selectedExteraCleaning = [];

    return Container(child: BlocBuilder<SchedulBloc, SchedulState>(
      builder: (context, state) {
        if (state is LoadingSchedulState) {
          return LoadingWidget();
        } else if (state is ErrorSchedulState) {
          return Center(
            child: Text("${state.message}"),
          );
        } else if (state is LoadedSchedulState) {
          print("$state ================");
          return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: showSchedule(_days, state.schedule));
        }

        return Center(child: Text("${state.toString()}"));
      },
    ));

    // return _showSchedule(_days);
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<SchedulBloc>(context).add(RefreshScheduleEvent());
    // final x = BlocProvider.of<SchedulBloc>(context).getAllScheduleUsecase;
    // print("$x");
    return Future.value(Unit);
  }
}

// print(c.time.toString());
// print(c.isHappening.toString());

