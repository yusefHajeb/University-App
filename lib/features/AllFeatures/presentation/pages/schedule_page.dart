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

    // return Container(
    //     child: BlocConsumer<SchedulBloc, SchedulState>(
    //   builder: (context, state) {
    //     if (state is LoadingSchedulState) {
    //       return RefreshIndicator(
    //           onRefresh: () => _onRefresh(context),
    //           child: _showSchedule(_days));
    //     } else if (state is LoadedSchedulState) {
    //       return RefreshIndicator(
    //           onRefresh: () => _onRefresh(context),
    //           child: _showSchedule(_days));
    //     }
    //     return const LoadingWidget();
    //   },
    //   listener: (context, state) {},
    // ));

    return _showSchedule(_days);
  }

  _showSchedule(List<dynamic> _days) {
    int _selectedDay = 2;
    int _selectedRepeat = 0;
    String _selectedHour = '13:30';
    List<int> _selectedExteraCleaning = [];

    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 120.0, right: 20.0, left: 20.0),
                child: Text(
                  'Select Date \nand Time',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ];
        },
        body: Column(children: <Widget>[
          Row(
            children: [
              Text("October 2023"),
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
              color: Colors.white,
              border: Border.all(width: 1.5, color: Colors.grey.shade200),
            ),
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _days.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {},
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: 62,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: _selectedDay == _days[index][0]
                            ? Colors.blue.shade100.withOpacity(0.5)
                            : Colors.blue.withOpacity(0),
                        border: Border.all(
                          color: _selectedDay == _days[index][0]
                              ? Colors.blue
                              : Colors.white.withOpacity(0),
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _days[index][0].toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            _days[index][1],
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )
        ]));
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
