import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:university/core/Utils/box_decoration.dart';
import 'package:university/core/color/app_color.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/core/fonts/app_fonts.dart';
import 'package:university/core/value/app_space.dart';
import 'package:university/core/value/style_manager.dart';
import 'package:university/core/widget/application_wedget.dart';
import 'package:university/features/AllFeatures/data/models/user_data.dart';
import 'package:university/features/AllFeatures/presentation/bloc/lading_page/lading_page_bloc.dart';
import 'package:university/features/AllFeatures/presentation/resources/assets_mananger.dart';
import '../../../../core/value/global.dart';
import '../../../../core/widget/dummy/image_net.dart';
import '../../data/models/auth_models/singup_model.dart';
import '../widget/profile_widget/text_autline.dart';
import 'onboarding/onboarding_start.dart';
import 'profile/edite_data_user_page.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class ApplicationPage extends StatelessWidget {
  const ApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    List libraryCarouslImg = const [
      ImageAssets.imageOne,
      ImageAssets.imageTow,
      ImageAssets.imageThree
    ];
    // final sizeWidth = ScreenUtil().screenWidth;
    // final sizeHeight = ScreenUtil().scaleHeight;
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundAccentColor,
      body: WillPopScope(
        onWillPop: () async {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
          });
          return true;
        },
        child: BlocConsumer<LadingPageBloc, LadingPageState>(
          // this to bottomnavigation Bar to button
          listener: (context, state) {
            if (state is LadingPageInitial) {
              context.read<LadingPageBloc>().add(TabChange(0));
            }
          },
          builder: (context, state) {
            // final sizeWidth = ScreenUtil().screenWidth;
            // final sizeHeight = ScreenUtil().scaleHeight;
            return Container(
              color: AppColors.backgroundPages,
              child: SafeArea(
                  child: Scaffold(
                body: buildPage(state.tabIndex, context),
                drawer: DrawerWidget(context),
                bottomNavigationBar: Container(
                  height: 59.h,
                  width: 375.w,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.greyColor.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.h),
                          topRight: Radius.circular(20.h))),
                  child: BottomNavigationBar(
                    items: bottomNavItems,
                    // enableFeedback: true,
                    // fixedColor: AppColors.greyColor,
                    // elevation: 0,
                    // backgroundColor: AppColors.error,
                    showUnselectedLabels: true,

                    selectedIconTheme: IconThemeData(
                      color: AppColors.error,
                    ),
                    currentIndex: state.tabIndex,
                    showSelectedLabels: true,
                    selectedLabelStyle:
                        getFontNormal(10, FontWeight.bold, AppColors.greyColor),
                    unselectedItemColor: AppColors.greyColor,
                    selectedItemColor: AppColors.white,

                    unselectedLabelStyle: getFontNormal(
                        10, FontWeightManager.black, AppColors.greyColor),

                    onTap: ((value) {
                      //get data to index in bloc and refresh value in ui
                      BlocProvider.of<LadingPageBloc>(context)
                          .add(TabChange(value));
                    }),
                  ),
                ),
                // body: buildPage(state.tabIndex),

                // when state.tabindex =1 not use singleChil... .becuase show error
                // ? buildPage(state.tabIndex, context)
                // : SingleChildScrollView(
                //     child: buildPage(state.tabIndex, context)),
              )),
            );
          },
        ),
      ),
    );
  }
}

Widget DrawerWidget(BuildContext context) {
  SingUpModel student = userDataModel();
  return Drawer(
    child: ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          color: AppColors.backgroundPages,
          height: appSize(context).height / 3,
          child: DrawerHeader(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeIn,
            child: SizedBox(
              child: Column(
                children: [
                  ProfileDummyNet(
                      color: HexColor.fromHex("94F0F1"),
                      dummyType: ProfileDummyTypeNet.image,
                      scale: 3.0,
                      image: student.image),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text("${student.name}",
                        style: GoogleFonts.almarai(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  // FeatherIconData(FeatherIcons.activity)                    Icon(FeatherIcons.alertTriangle,
                  //     color: AppColors.white, size: 30),
                  Text("${student.email}",
                      style: GoogleFonts.lato(
                          color: HexColor.fromHex("B0FFE1"), fontSize: 14)),
                  AppSpaces.verticalSpace5,
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: OutlinedButtonWithText(
                        width: 74,
                        content: "تعديل",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const EditeUserData(),
                              ));
                          // Get.to(() => EditProfilePage());
                        }),
                  ),
                  // AppSpaces.verticalSpace20,
                  // Container(
                  //   child: Center(
                  //     child: Text(student.name.toString(),
                  //         style:
                  //             getFontNormal(23, FontWeight.bold, AppColors.green)),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: appSize(context).height / 1.3,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecorationStyles.fadingGlory,
          child: SizedBox(
            // height: 300,
            child: ListView(shrinkWrap: true, children: <Widget>[
              Container(
                decoration: BoxDecorationStyles.headerTab,
                child: ListTile(
                  leading: Icon(
                    Icons.home_outlined,
                    color: AppColors.greyColor,
                  ),
                  title: Text(
                    'الرئيسية',
                    style: getFontNormal(
                        15, FontWeightManager.medium, AppColors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    context.read<LadingPageBloc>().add(TabChange(0));
                  },
                ),
              ),
              AppSpaces.verticalSpace10,
              Container(
                decoration: BoxDecorationStyles.headerTab,
                child: ListTile(
                  leading: Icon(
                    Icons.account_box_outlined,
                    color: AppColors.greyColor,
                  ),
                  title: Text(
                    'عرض الملف الشخصي',
                    style: getFontNormal(
                        15, FontWeightManager.medium, AppColors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    context.read<LadingPageBloc>().add(TabChange(4));
                  },
                ),
              ),
              Container(
                decoration: BoxDecorationStyles.headerTab,
                child: ListTile(
                  leading: Icon(
                    Icons.mode_edit_outline,
                    size: 20,
                    color: AppColors.greyColor,
                  ),
                  title: Text(
                    'تعديل الملف الشخصي',
                    style: getFontNormal(
                        15, FontWeightManager.medium, AppColors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EditeUserData(),
                        ));
                  },
                ),
              ),
              AppSpaces.verticalSpace10,
              Container(
                decoration: BoxDecorationStyles.headerTab,
                child: ListTile(
                  leading: Icon(
                    Icons.download_for_offline_outlined,
                    color: AppColors.greyColor,
                  ),
                  title: Text(
                    'التنزيلات',
                    style: getFontNormal(
                        15, FontWeightManager.medium, AppColors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);

                    context.read<LadingPageBloc>().add(TabChange(2));
                  },
                ),
              ),
              AppSpaces.verticalSpace10,
              Container(
                decoration: BoxDecorationStyles.headerTab,
                child: ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: AppColors.greyColor,
                  ),
                  title: Text(
                    'تسجيل الخروج',
                    style: getFontNormal(
                        15, FontWeightManager.medium, AppColors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Global.storgeServece.setBool(
                        Constants.STORGE_DEVICE_OPEN_FIRST_TIME, false);
                    Global.storgeServece
                        .setBool(Constants.STORGE_USER_LOGED_FIRST, false);

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OnboardingCarousel(),
                        ),
                        (route) => false);
                  },
                ),
              ),

              // ListTile(
              //   leading: Icon(Icons.settings),
              //   title: Text('Settings'),
              //   onTap: () {
              //     Navigator.pop(context);
              //   },
              // ),
            ]),
          ),
        ),
      ],
    ),
  );
}
