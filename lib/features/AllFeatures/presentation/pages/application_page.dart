import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:university/core/color/app_color.dart';
import 'package:university/core/widget/application_wedget.dart';
import 'package:university/features/AllFeatures/presentation/bloc/lading_page/lading_page_bloc.dart';

class LadingPage extends StatelessWidget {
  const LadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LadingPageBloc, LadingPageState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
            child: Scaffold(
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.greyColor.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                  ),
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(20))),
            child: BottomNavigationBar(
              items: bottomNavItems,
              // elevation: 0,
              type: BottomNavigationBarType.shifting,
              currentIndex: state.tabIndex,
              showSelectedLabels: true,
              // showUnselectedLabels: false,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: AppColors.greyColor,
              onTap: ((value) {
                BlocProvider.of<LadingPageBloc>(context).add(TabChange(value));
              }),
            ),
          ),
          body: buildPage(0),
        ));
      },
    );
  }
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
