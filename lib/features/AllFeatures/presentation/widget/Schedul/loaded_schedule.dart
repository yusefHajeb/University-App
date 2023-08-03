import 'package:flutter/material.dart';

import '../../../domain/entites/schedule.dart';
import 'cards_schedule.dart';

showSchedule(List<dynamic> _days, List<Schedule> data) {
  int _selectedDay = 2;
  int _selectedRepeat = 0;
  String _selectedHour = '13:30';
  List<int> _selectedExteraCleaning = [];

  //  final List<String> weekdays = DateFormat.E().narrow;
  return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 120.0, right: 20.0, left: 20.0),
              child: Text(
                ' Today lectures \nand Time',
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
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
          ),
          CardSchedule()
        ]),
      ));
}
