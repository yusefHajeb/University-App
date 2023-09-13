import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:university/app/extensions.dart';
import 'package:university/core/color/app_color.dart';
import 'package:university/core/fonts/app_fonts.dart';
import 'package:university/core/value/app_space.dart';
import 'package:university/core/widget/application_wedget.dart';
import 'package:university/features/AllFeatures/presentation/bloc/lading_page/lading_page_bloc.dart';
import 'package:university/features/AllFeatures/presentation/resources/assets_mananger.dart';
import '../../../../core/Utils/box_decoration.dart';
import '../bloc/services_bloc/services_bloc.dart';
import '../widget/library_widget.dart/custom_search.dart';

class LadingPage extends StatelessWidget {
  const LadingPage({super.key});

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
          // body: buildPage(state.tabIndex),
          body: SingleChildScrollView(
            child: Column(children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.asset("assets/icons/menus.png", height: 35),
                    CustomInputSerch(),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.notifications_none_rounded)),
                  ],
                ),
              ),
              AppSpaces.verticalSpace10,
              Container(
                child: CarouselSlider(
                  items: libraryCarouslImg.map((imageUrl) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecorationStyles.fadingInnerDecor,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: InteractiveViewer(
                          clipBehavior: Clip.hardEdge,
                          child: Image.asset(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                      height: 180,
                      onPageChanged: (int val, _) {},
                      animateToClosest: false,
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      enlargeCenterPage:
                          true, //to image show is biger than behaind
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayInterval: Duration(seconds: 4),
                      autoPlay: false),
                ),
              ),
              Container(
                child: DotsIndicator(
                  dotsCount: 4,
                  position: 3,
                  decorator: DotsDecorator(
                      color: AppColors.darkGrey,
                      size: Size.square(8.0),
                      activeSize: Size(18.0, 8.0),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      activeColor: AppColors.primaryAccentColor),
                ),
              ),
              AppSpaces.verticalSpace20,
              Container(
                child: Text("Hello"),
              ),
              BlocConsumer<ServicesBloc, ServicesState>(
                listener: (context, state) {
                  if (state is ServiceCurentState) {
                    BlocProvider.of<ServicesBloc>(context)
                        .add(ServiceCurentEvent(cureent: state.curent));
                  }
                  // state.curent = state.curent;
                },
                builder: (context, state) {
                  // int curent = state.curent;
                  return Container(
                    width: sizeWidth,
                    height: sizeHeight * 30,
                    // color: AppColors.backgroundPages,
                    // decoration: BoxDecorationStyles.cardSchedule,
                    child: Stack(children: [
                      Positioned(
                        top: 0,
                        left: 2,
                        child: Container(
                          width: sizeWidth,
                          height: sizeHeight * 20,
                          // color: Colors.amber,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) {
                              return GestureDetector(
                                onTap: () {
                                  state.curent = index;
                                  state.leftCurent =
                                      changePostionedOfLine(state.curent);
                                  print(
                                      "$index === ${state.curent} ==== ${state.leftCurent}");
                                  BlocProvider.of<ServicesBloc>(context).add(
                                      ServiceCurentEvent(
                                          cureent: state.curent));
                                },
                                child: Container(
                                  width: sizeWidth / 5,
                                  child: Text(
                                    tab[index],
                                    style: TextStyle(
                                        color: state.curent == index
                                            ? AppColors.primaryAccentColor
                                            : AppColors.darkGrey,
                                        fontWeight: state.curent == index
                                            ? FontWeightManager.black
                                            : FontWeightManager.medium,
                                        fontSize: 12),
                                  ),
                                ),
                              );
                            }),
                            itemCount: tab.length,
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                          bottom: 0,
                          left: state.leftCurent.toDouble(),
                          curve: Curves.fastLinearToSlowEaseIn,
                          duration: Duration(milliseconds: 500),
                          child: AnimatedContainer(
                            width: 50,
                            height: sizeHeight * 5,
                            decoration: BoxDecorationStyles.backgroundBlack,
                            duration: Duration(milliseconds: 400),
                          ))
                    ]),
                  );
                },
              ),
              AppSpaces.verticalSpace20,
            ]),
          ),
        ));
      },
    );
  }
}
// List libraryCarouslImg = [
//   ImageAssets.imageOne,
//   ImageAssets.imageTow,
//   ImageAssets.imageThree
// ];