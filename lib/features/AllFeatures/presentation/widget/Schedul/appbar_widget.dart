import 'package:flutter/material.dart';

import '../../../../../core/constant/varibal.dart';

PreferredSize appBarSceduleWidget(BuildContext context) {
  return PreferredSize(
    preferredSize: Size(
      double.infinity,
      appSize(context).height / 3.9,
    ),
    //Container Photo Home Pag..
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Jun",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("01", style: kCalendarDay),
                    Text("02", style: kCalendarDay),
                    Text("03", style: kCalendarDay),
                    Text(
                      "04",
                      style: kCalendarDay.copyWith(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text("05", style: kCalendarDay),
                    Text("06", style: kCalendarDay),
                    Text("07", style: kCalendarDay),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 150.0, top: 3.0),
                  child: Text(
                    "THU",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
