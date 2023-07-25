import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:university/core/Utils/lang/app_localization.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/features/AllFeatures/presentation/bloc/Onboarding/onboarding_cubit.dart';
import '../../../../../core/color/app_color.dart';
import '../../../../../core/widget/bakground_dark.dart';
import '../../cubit/localization/local_cubit_cubit.dart';
import '../../widget/onBoarding/slider_image.dart';
import '../Auth/singup_page.dart';

class OnboardingCarousel extends StatefulWidget {
  @override
  _OnboardingCarouselState createState() => _OnboardingCarouselState();
}

class _OnboardingCarouselState extends State<OnboardingCarousel> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  // List<Widget> _buildPageIndicator() {
  //   List<Widget> list = [];
  //   for (int i = 0; i < _numPages; i++) {
  //     list.add(i == _currentPage ? _indicator(true) : _indicator(false));
  //   }
  //   return list;
  // }

  final OnboardingCubit boardingCubit = OnboardingCubit();
  final LocaleCubit localCubit = LocaleCubit();
  // Widget _indicator(bool isActive) {
  //   return AnimatedContainer(
  //     duration: Duration(milliseconds: 150),
  //     margin: EdgeInsets.symmetric(horizontal: 8.0),
  //     height: 8.0,
  //     width: 8.0,
  //     decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color:
  //           isActive ? HexColor.fromHex("266FFE") : HexColor.fromHex("666A7A"),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(children: [
              Container(
                // height: double.infinity,
                // width: double.infinity,
                child: DarkRadialBackground(
                  color: HexColor.fromHex("#181a1f"),
                  position: "bottomRight",
                ),
              ),
              //Buttons positioned below
              Column(children: [
                Container(
                  height: sizeHeight(context).width * 1.3 - 20,
                  child: BlocConsumer<OnboardingCubit, OnboardingState>(
                    listener: ((context, state) {
                      if (state == OnboardingState.Complete) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => SingUpPage()),
                            (route) => false);
                      }
                    }),
                    bloc: boardingCubit,
                    builder: ((context, state) {
                      return PageView(
                          physics: ClampingScrollPhysics(),
                          controller: _pageController,
                          onPageChanged: (int page) {
                            boardingCubit.onChangePage(page);
                          },
                          children: <Widget>[
                            SliderCaptionedImage(
                                index: 0,
                                imageUrl:
                                    "assets/images/slider-background-1.png",
                                caption: "onBoarding1".tr(context)),
                            SliderCaptionedImage(
                                index: 1,
                                imageUrl:
                                    "assets/images/slider-background-3.png",
                                caption: "onBoarding2".tr(context)),
                            SliderCaptionedImage(
                                index: 2,
                                imageUrl:
                                    "assets/images/slider-background-2.png",
                                caption: "onBoarding3".tr(context))
                          ]);
                    }),
                  ),
                ),
                Container(
                  child: BlocConsumer<LocaleCubit, ChangeLocalState>(
                      bloc: localCubit,
                      listener: (context, state) {
                        Navigator.pop(context);
                      },
                      builder: (context, state) {
                        return DropdownButton<String>(
                            dropdownColor: Colors.white,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                            underline: Container(
                              height: 2,
                              color: Color.fromARGB(255, 14, 30, 44),
                            ),
                            value: state.locale.languageCode,
                            items: ['ar', 'en']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                alignment: Alignment.center,
                                child: Container(
                                  color: Colors.white,
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                BlocProvider.of<LocaleCubit>(context)
                                    .changeLanguage(newValue);

                                // context
                                //     .read<LocaleCubit>()
                                //     .changeLanguage(newValue);
                                // Navigator.pop(context);
                              }
                            });
                      }),
                ),
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
                                BlocProvider.of<OnboardingCubit>(context)
                                    .onChangePage(2);
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      HexColor.fromHex("246CFE")),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          side: BorderSide(
                                              color: HexColor.fromHex(
                                                  "246CFE"))))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.chevron_left_sharp,
                                      color: Colors.white),
                                  Text("   Continue ".tr(context),
                                      style: GoogleFonts.lato(
                                          fontSize: 20, color: Colors.white)),
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
                              style: GoogleFonts.lato(
                                  fontSize: 15,
                                  color: HexColor.fromHex("666A7A"))),
                        )
                      ]),
                    ),
                  ),
                ),
              ])
            ])));
  }
}
