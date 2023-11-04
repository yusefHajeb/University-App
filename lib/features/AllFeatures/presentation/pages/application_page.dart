import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:university/core/color/app_color.dart';
import 'package:university/core/fonts/app_fonts.dart';
import 'package:university/core/value/style_manager.dart';
import 'package:university/core/widget/application_wedget.dart';
import 'package:university/features/AllFeatures/presentation/bloc/lading_page/lading_page_bloc.dart';
import 'package:university/features/AllFeatures/presentation/resources/assets_mananger.dart';
import '../../../../core/widget/custom_drawer.dart';

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
            return Container(
              color: AppColors.backgroundPages,
              child: SafeArea(
                child: Scaffold(
                  body: buildPage(state.tabIndex, context),
                  drawer: DrawerWidget(),
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
                      showUnselectedLabels: true,
                      type: BottomNavigationBarType.fixed,
                      selectedIconTheme: IconThemeData(
                        color: AppColors.error,
                      ),
                      currentIndex: state.tabIndex,
                      showSelectedLabels: true,
                      selectedLabelStyle: getFontNormal(
                          10, FontWeight.bold, AppColors.greyColor),
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
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
