import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:university/features/AllFeatures/presentation/bloc/SchedulBloc/schedul_bloc.dart';
import '../../../../core/color/app_color.dart';
import '../../../../core/widget/custom_drawer.dart';
import '../widget/Schedul/loaded_schedule.dart';

class SchedulePage extends StatelessWidget {
  SchedulePage({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: DrawerWidget(),
        backgroundColor: AppColors.backgroundPages,
        body: buildBody(context));
  }
}

Future<void> _onRefresh(BuildContext context) async {
  BlocProvider.of<ScheduleBloc>(context).add(RefreshScheduleEvent());
  return Future.value(unit);
}

Widget buildBody(BuildContext context) {
  final day = DateFormat('dd').format(DateTime.now());
  return showSchedule(4, day);
}
