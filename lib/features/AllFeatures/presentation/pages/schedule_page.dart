import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/core/widget/loading_widget.dart';
import 'package:university/features/AllFeatures/presentation/bloc/SchedulBloc/schedul_bloc.dart';
import '../../domain/entites/schedule.dart';
import '../widget/Schedul/appbar_widget.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarSceduleWidget(context), body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return Container(
        child: BlocConsumer<SchedulBloc, SchedulState>(
      builder: (context, state) {
        if (state is LoadingSchedulState) {
          return LoadingWidget();
        } else if (state is LoadedSchedulState) {
          return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: _showSchedule(state.schedule));
        }
        return const LoadingWidget();
      },
      listener: (context, state) {},
    ));
  }

  _showSchedule(List<Schedule> schedule) {
    return ListView.builder(
      shrinkWrap: true,
      reverse: true,
      physics: BouncingScrollPhysics(),
      itemCount: schedule.length,
      itemBuilder: (BuildContext context, int index) {
        _getStatus(schedule[index]);
        return Column(
          children: <Widget>[
            Row(),
          ],
        );
      },
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<SchedulBloc>(context).add(RefreshScheduleEvent());
    return Future.value(Unit);
  }
}

_getStatus(Schedule c) {
  DateTime now = DateTime.now();
  DateTime finishedTime = c.time!.add(Duration(hours: 1));
  if (now.difference(c.time!).inMinutes >= 59) {
    c.isPassed = true;
  } else if (now.difference(c.time!).inMinutes <= 59 &&
      now.difference(finishedTime).inMinutes >= -59) {
    c.isHappening = true;
  }
  // print(c.time.toString());
  // print(c.isHappening.toString());
}
