import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:university/core/Utils/lang/app_localization.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/core/fonts/app_fonts.dart';
import 'package:university/features/AllFeatures/presentation/bloc/Onboarding/onboarding_cubit.dart';
import 'package:university/features/AllFeatures/presentation/widget/onBoarding/custom_slider.dart';
import '../../../../../core/color/app_color.dart';
import '../../../../../core/value/style_manager.dart';
import '../../../../../core/widget/bakground_dark.dart';
import '../../cubit/localization/local_cubit_cubit.dart';
import '../../widget/onBoarding/custom_change_lang.dart';
import '../../widget/onBoarding/slider_image.dart';
import '../Auth/singup_page.dart';
import '../schedule_page.dart';

class OnboardingCarousel extends StatefulWidget {
  @override
  _OnboardingCarouselState createState() => _OnboardingCarouselState();
}

class _OnboardingCarouselState extends State<OnboardingCarousel> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final LocaleCubit localCubit = LocaleCubit();

  @override
  Widget build(BuildContext context) {
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
              Column(children: [
                Container(
                    height: sizeHeight(context).width * 1.3 - 20,
                    child: CustomSlider()),
                ChangeLang(localCubit: localCubit),
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
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                              onPressed: () {
                                OnboardingDirection dirction;
                                final current =
                                    BlocProvider.of<OnboardingCubit>(context)
                                        .state;
                                final old =
                                    BlocProvider.of<OnboardingCubit>(context)
                                        .state;

                                print(old);
                                if (BlocProvider.of<OnboardingCubit>(context)
                                        .state ==
                                    2) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => SchedulePage()));
                                } else {
                                  dirction = OnboardingDirection.forward;
                                  BlocProvider.of<OnboardingCubit>(context)
                                      .changePage(current + 1, dirction);
                                  print(
                                      "${BlocProvider.of<OnboardingCubit>(context).state} ====");
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.primaryColor),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
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
              ])
            ])));
  }
}
