import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../color/app_color.dart';

Widget buildPage(int index) {
  List<Widget> __widget = const [
    Center(
      child: Text("Home"),
    ),
    Center(
      child: Text("Login"),
    ),
    Center(
      child: Text("schedule"),
    ),
    Center(
      child: Text("None"),
    )
  ];
  return __widget[index];
}

List<BottomNavigationBarItem> bottomNavItems = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
      label: "Home",
      icon: SvgPicture.asset("assets/icons/house.svg",
          color: AppColors.kBGColor, width: 35.0)),
  BottomNavigationBarItem(
      label: "schedule",
      icon: SvgPicture.asset("assets/icons/calendar.svg", width: 35.0)),
  BottomNavigationBarItem(
      label: "homework",
      icon: SizedBox(
          width: 40,
          height: 40,
          child: SvgPicture.asset("assets/icons/homework.svg", width: 35.0))),
  BottomNavigationBarItem(
      label: "book",
      icon: SvgPicture.asset("assets/icons/house.svg", width: 35.0)),
  BottomNavigationBarItem(
      label: "book2",
      icon: SvgPicture.asset("assets/icons/read_book.svg", width: 35.0)),
];
