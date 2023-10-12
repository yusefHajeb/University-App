import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/color/app_color.dart';
import 'package:university/core/widget/application_wedget.dart';
import 'package:university/features/AllFeatures/presentation/bloc/lading_page/lading_page_bloc.dart';
import 'package:university/features/AllFeatures/presentation/resources/assets_mananger.dart';
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

    return BlocConsumer<LadingPageBloc, LadingPageState>(
      // this to bottomnavigation Bar to button
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
              // fixedColor: AppColors.greyColor,
              // elevation: 0,
              backgroundColor: AppColors.error,

              type: BottomNavigationBarType.shifting,
              currentIndex: state.tabIndex,
              showSelectedLabels: true,

              // showUnselectedLabels: false,
              selectedItemColor: AppColors.primaryAccentColor,
              unselectedItemColor: AppColors.primaryAccentColor,
              onTap: ((value) {
                //get data to index in bloc and refresh value in ui
                BlocProvider.of<LadingPageBloc>(context).add(TabChange(value));
              }),
            ),
          ),
          // body: buildPage(state.tabIndex),

          // when state.tabindex =1 not use singleChil... .becuase show error
          body: state.tabIndex == 1
              ? buildPage(state.tabIndex, context)
              : SingleChildScrollView(
                  child: buildPage(state.tabIndex, context)),
        ));
      },
    );
  }
}
