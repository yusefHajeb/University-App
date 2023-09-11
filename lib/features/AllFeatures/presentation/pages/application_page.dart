import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:university/core/color/app_color.dart';
import 'package:university/core/widget/application_wedget.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: AppColors.white,
        ),
        child: SafeArea(
          child: Scaffold(
              body: buildPage(1),
              bottomNavigationBar: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.greyColor.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  child: BottomNavigationBar(
                      elevation: 0,
                      type: BottomNavigationBarType.fixed,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      selectedItemColor: AppColors.primaryAccentColor,
                      unselectedItemColor: AppColors.greyColor,
                      items: [
                        BottomNavigationBarItem(
                            label: "Home",
                            icon: SvgPicture.asset("assets/icons/house.svg",
                                color: AppColors.kBGColor, width: 35.0)),
                        BottomNavigationBarItem(
                            label: "schedule",
                            icon: SvgPicture.asset("assets/icons/calendar.svg",
                                width: 35.0)),
                        BottomNavigationBarItem(
                            label: "homework",
                            icon: SizedBox(
                                width: 40,
                                height: 40,
                                child: SvgPicture.asset(
                                    "assets/icons/homework.svg",
                                    width: 35.0))),
                        BottomNavigationBarItem(
                            label: "book",
                            icon: SvgPicture.asset("assets/icons/house.svg",
                                width: 35.0)),
                        BottomNavigationBarItem(
                            label: "book2",
                            icon: SvgPicture.asset("assets/icons/read_book.svg",
                                width: 35.0)),
                      ]))),
        ));
  }
}
