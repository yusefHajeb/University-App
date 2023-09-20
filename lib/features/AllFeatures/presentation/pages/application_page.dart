import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:university/core/color/app_color.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/core/fonts/app_fonts.dart';
import 'package:university/core/value/app_space.dart';
import 'package:university/core/widget/application_wedget.dart';
import 'package:university/features/AllFeatures/presentation/bloc/lading_page/lading_page_bloc.dart';
import 'package:university/features/AllFeatures/presentation/resources/assets_mananger.dart';
import '../../../../core/Utils/box_decoration.dart';
import '../../domain/entites/header_books_entites.dart';
import '../widget/Auth Widget/submet_login.dart';
import '../widget/library_widget.dart/custom_search.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class ApplicationPage extends StatelessWidget {
  const ApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    List libraryCarouslImg = [
      ImageAssets.imageOne,
      ImageAssets.imageTow,
      ImageAssets.imageThree
    ];
    final sizeWidth = ScreenUtil().screenWidth;
    final sizeHeight = ScreenUtil().scaleHeight;
    List<String> tab = [
      "network",
      "Flutter",
      "AI",
      "Image Processing",
      "Web",
      "C#"
    ];
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
              // elevation: 0,
              type: BottomNavigationBarType.shifting,
              currentIndex: state.tabIndex,
              showSelectedLabels: true,
              // showUnselectedLabels: false,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: AppColors.greyColor,
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
