import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:university/core/Utils/lang/app_localization.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/core/fonts/app_fonts.dart';
import 'package:university/features/AllFeatures/domain/entites/onboarding_model/slider_view_object.dart';
import 'package:university/features/AllFeatures/presentation/bloc/bloc/on_boarding_bloc_bloc.dart';
import 'package:university/features/AllFeatures/presentation/pages/onboarding/view/onboarding_vm.dart';
import '../../../../../core/color/app_color.dart';
import '../../../../../core/value/global.dart';
import '../../../../../core/value/style_manager.dart';
import '../../../../../core/widget/bakground_dark.dart';
import '../../../domain/entites/onboarding_model/slider_object.dart';
import '../../cubit/localization/local_cubit_cubit.dart';
import '../../resources/assets_mananger.dart';
import '../../routes.dart';
import '../../widget/onBoarding/custom_change_lang.dart';
import '../../widget/onBoarding/slider_image.dart';
import '../Auth/sing_in_page.dart';
import '../Auth/singup_page.dart';
import '../schedule_page.dart';
import 'dart:math' as math;

class OnboardingCarousel extends StatefulWidget {
  @override
  _OnboardingCarouselState createState() => _OnboardingCarouselState();
}

class _OnboardingCarouselState extends State<OnboardingCarousel> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0;
  // OnBoardingVM viewMoldel = OnBoardingVM();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final LocaleCubit localCubit = LocaleCubit();

  // Widget _getContentWidget() {
  // if (sliderViewObject == null) {
  //   return Container();
  // }

  // }

  @override
  Widget build(BuildContext context) {
    int indexPage = 0;
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(children: [
              Container(
                child: DarkRadialBackground(
                  color: AppColors.backgroundPages,
                  position: "bottomRight",
                ),
              ),
              BlocConsumer<OnBoardingBlocBloc, OnBoardingBlocState>(
                  listener: ((context, state) {
                if (state is OnBoardingBlocState) {
                  indexPage = state.page;
                }
              }), builder: (context, state) {
                return Column(children: [
                  Container(
                    height: sizeHeight(context).width * 1.3 - 20,
                    child: PageView(
                      physics: ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (index) {
                        print("the index is $index  && state is ${state.page}");
                        state.page = index;
                        BlocProvider.of<OnBoardingBlocBloc>(context)
                            .add(OnBoardingBlocEvent());

                        // _pageController.animateToPage(state.page,
                        //     duration: const Duration(
                        //       milliseconds: 3,
                        //     ),
                        //     curve: Curves.bounceInOut);

                        // viewMoldel.goNext();
                        // if (viewMoldel.currentPageIndex == 4) {
                        //   Navigator.push(context,
                        //       MaterialPageRoute(builder: (_) => SchedulePage()));
                        // }
                      },
                      children: [
                        OnBoardingPage(0),
                        OnBoardingPage(1),
                        OnBoardingPage(2)
                      ],
                      // itemBuilder: (context, index) {
                      //   return OnBoardingPage(index);
                      // },
                      // itemCount: _getSliderData.length,
                    ),
                  ),
                  // ChangeLang(localCubit: localCubit),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // children: _buildPageIndicator(),
                          ),
                          SizedBox(height: 50),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: SmoothPageIndicator(
                              controller: _pageController,
                              effect: WormEffect(
                                  spacing: 16,
                                  dotColor: AppColors.darkGrey,
                                  activeDotColor: AppColors.primaryColor),
                              // offset: 3,
                              count: 3,
                              // size: Size.square(8.0),
                              onDotClicked: ((index) =>
                                  _pageController.animateToPage(index,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeIn)),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                                onPressed: () {
                                  // state.page = indexPage;
                                  BlocProvider.of<OnBoardingBlocBloc>(context)
                                      .add(OnBoardingBlocEvent());
                                  // indexPage = state.page;

                                  if (state.page < 3) {
                                    print("${state.page} ======");
                                    _pageController.animateToPage(state.page,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeIn);
                                  } else {
                                    // Global.storgeServece.setBool(
                                    //     Constants.STORGE_DEVICE_OPEN_FIRST_TIME,
                                    //     true);
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => SingInPage()),
                                        (route) => false);
                                  }

                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (_) => const SingInPage()));

                                  // _pageController.animateToPage(

                                  //     duration: const Duration(
                                  //       milliseconds: 3,
                                  //     ),
                                  //     curve: Curves.bounceInOut);
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColors.primaryColor),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(200.0),
                                    ))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.chevron_left_sharp,
                                        color: Colors.white),
                                    Text("   Continue ".tr(context),
                                        style: bigHeaderEn(
                                            fontSize: FontSize.s20,
                                            color: Colors.white)),
                                  ],
                                )),
                          ),
                          SizedBox(height: 10.0),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                                "By continuing you agree University Terms of Services & Privacy Policy.,"
                                    .tr(context),
                                textAlign: TextAlign.center,
                                style: smallHeaderEn(
                                    color: AppColors.bottomHeaderColor)),
                          )
                        ]),
                      ),
                    ),
                  ),
                ]);
              })
            ])));
  }
}
