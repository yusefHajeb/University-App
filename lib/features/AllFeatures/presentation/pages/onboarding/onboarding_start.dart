import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/features/AllFeatures/presentation/bloc/Onboarding/onboarding_cubit.dart';
import '../../../../../core/color/app_color.dart';
import '../../../../../core/widget/bakground_dark.dart';
import '../../widget/onBoarding/image_outline.dart';
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

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  final OnboardingCubit boardingCubit = OnboardingCubit();
  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            isActive ? HexColor.fromHex("266FFE") : HexColor.fromHex("666A7A"),
      ),
    );
  }

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
                                  caption: "University,\nCalendar,\nChat"),
                              SliderCaptionedImage(
                                  index: 1,
                                  imageUrl:
                                      "assets/images/slider-background-3.png",
                                  caption: "University\nAnywhere\nEasily"),
                              SliderCaptionedImage(
                                  index: 2,
                                  imageUrl:
                                      "assets/images/slider-background-2.png",
                                  caption: "Manage\nUniversity\nOn Phone")
                            ]);
                      }),
                    )),
                Padding(
                  padding:
                      EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: _buildPageIndicator(),
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
                                  Icon(Icons.email, color: Colors.white),
                                  Text('   Continue ',
                                      style: GoogleFonts.lato(
                                          fontSize: 20, color: Colors.white)),
                                ],
                              )),
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                              'By continuing you agree Taskez\'s Terms of Services & Privacy Policy.',
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
