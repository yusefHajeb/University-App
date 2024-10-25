import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:university/chat/domain/entities/student_entity.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/features/AllFeatures/data/models/user_data.dart';
import 'package:university/features/AllFeatures/presentation/pages/notification/notification_all.dart';
import 'package:university/features/AllFeatures/presentation/pages/schedule_page.dart';
import '../../chat/presentation/pages/home_page.dart';
import '../../features/AllFeatures/presentation/pages/library/books_saves_page.dart';
import '../../features/AllFeatures/presentation/pages/library/library_pages.dart';
import '../../features/AllFeatures/presentation/resources/assets_mananger.dart';
import '../color/app_color.dart';

Widget buildPage(
  int index,
  BuildContext context,
) {
  List libraryCarouslImg = [
    ImageAssets.imageOne,
    ImageAssets.imageTow,
  ];
  ScreenUtil.init(context);

  final sizeWidth = ScreenUtil().screenWidth;
  final sizeHeight = ScreenUtil().scaleHeight;
  List<Widget> widget = [
    SizedBox(height: appSize(context).height, child: SchedulePage()),
    SizedBox(
      height: appSize(context).height,
      child: LibraryPage(
        libraryCarouslImg: libraryCarouslImg,
        sizeHeight: sizeHeight,
        sizeWidth: sizeWidth,
      ),
    ),
    const Center(child: BooksDownloaded()),
    HomePage(
        uid: StudentEntity(
            t_id: int.parse(userDataModel().tId ?? "3"),
            batch_id: int.parse(userDataModel().batchId ?? "4"),
            std_image: userDataModel().image ?? "",
            std_name: userDataModel().name ?? "")),

    // BlocBuilder<AuthCubit, AuthState>(
    //   builder: (context, authState) {
    //     if (authState is Authenticated) {
    //       return HomePage(
    //           uid: StudentEntity(batch_id: 12, std_image: "", std_name: "2"));
    //     } else
    //       return LoginPage();
    //   },
    // ),
    const NotificationPage()
  ];
  return widget[index];
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
    ),
  ),
];
