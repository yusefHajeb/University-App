import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/features/AllFeatures/presentation/pages/schedule_page.dart';
import '../../features/AllFeatures/presentation/pages/books_saves_page.dart';
import '../../features/AllFeatures/presentation/pages/library/library_pages.dart';
import '../../features/AllFeatures/presentation/pages/profile/profile_page.dart';
import '../../features/AllFeatures/presentation/resources/assets_mananger.dart';
import '../color/app_color.dart';

Widget buildPage(
  int index,
  BuildContext context,
) {
  List libraryCarouslImg = [
    ImageAssets.imageOne,
    ImageAssets.imageTow,
    ImageAssets.imageThree
  ];
  ScreenUtil.init(context);

  final sizeWidth = ScreenUtil().screenWidth;
  final sizeHeight = ScreenUtil().scaleHeight;
  List<Widget> __widget = [
    Container(height: appSize(context).height, child: SchedulePage()),
    Container(
      height: appSize(context).height,
      child: LibraryPage(
        libraryCarouslImg: libraryCarouslImg,
        sizeHeight: sizeHeight,
        sizeWidth: sizeWidth,
      ),
    ),
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
      label: "الجدول",
      backgroundColor: AppColors.backgroundAccentColor,
      icon: SizedBox(
        width: 20.w,
        height: 15.h,
        child: SvgPicture.asset(
          "assets/icons/calendar.svg",
          color: AppColors.white,
        ),
      )),
  BottomNavigationBarItem(
      backgroundColor: AppColors.backgroundAccentColor,
      label: "المكتبة",
      icon: SizedBox(
        width: 20.w,
        height: 15.h,
        child: SvgPicture.asset(
          "assets/icons/calendar.svg",
          color: AppColors.white,
          // width: ScreenUtil().screenWidth * .5,
          // height: ScreenUtil().scaleHeight * 20,
        ),
      )),
  BottomNavigationBarItem(
      backgroundColor: AppColors.backgroundAccentColor,
      label: "التنزيلات",
      icon: SizedBox(
        width: 20.w,
        height: 15.h,
        child: SvgPicture.asset(
          "assets/icons/homework.svg",
          color: AppColors.white,
        ),
      )),
  BottomNavigationBarItem(
      backgroundColor: AppColors.backgroundAccentColor,
      label: "المحادثة",
      icon: SizedBox(
        width: 20.w,
        height: 15.h,
        child: SvgPicture.asset(
          "assets/icons/comment.svg",
          color: AppColors.white,
        ),
      )),
  BottomNavigationBarItem(
      backgroundColor: AppColors.backgroundAccentColor,
      label: "الملف الشخصي",
      icon: SizedBox(
        width: 20.w,
        height: 15.h,
        child: SvgPicture.asset(
          "assets/icons/read_book.svg",
          color: AppColors.white,
        ),
      )),
];
