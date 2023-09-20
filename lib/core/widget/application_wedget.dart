import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/features/AllFeatures/presentation/pages/schedule_page.dart';

import '../../features/AllFeatures/presentation/pages/application_page.dart';
import '../../features/AllFeatures/presentation/pages/books_saves_page.dart';
import '../../features/AllFeatures/presentation/pages/library/library_pages.dart';
import '../../features/AllFeatures/presentation/pages/profile/profile_page.dart';
import '../../features/AllFeatures/presentation/resources/assets_mananger.dart';
import '../color/app_color.dart';

Widget buildPage(int index, BuildContext context) {
  List libraryCarouslImg = [
    ImageAssets.imageOne,
    ImageAssets.imageTow,
    ImageAssets.imageThree
  ];
  final sizeWidth = ScreenUtil().screenWidth;
  final sizeHeight = ScreenUtil().scaleHeight;
  List<Widget> __widget = [
    Container(
      height: appSize(context).height,
      color: AppColors.white,
      child: Library_page(
        libraryCarouslImg: libraryCarouslImg,
        sizeHeight: sizeHeight,
        sizeWidth: sizeWidth,
      ),
    ),
    Center(child: buildBody(context)),
    Center(child: BooksDownloaded()),
    Center(
      child: Text("None"),
    ),
    MyProfie(tabSpace: "\t\t")
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
