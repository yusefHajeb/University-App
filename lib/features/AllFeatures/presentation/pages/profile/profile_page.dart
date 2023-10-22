// import 'dart:html';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/core/value/global.dart';
import 'package:university/features/AllFeatures/data/models/auth_models/singup_model.dart';
import '../../../../../core/color/app_color.dart';
import '../../../../../core/value/app_space.dart';
import '../../../../../core/widget/bakground_dark.dart';
import '../../../../../core/widget/buttons/default_back.dart';
import '../../../../../core/widget/dummy/profile_dummy.dart';
import '../../widget/profile_widget/prfile_text.dart';
import '../../widget/profile_widget/text_autline.dart';
import '../onboarding/onboarding_start.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // final ValueNotifier<bool> totalTaskNotifier = ValueNotifier(true);
  final String tabSpace = "\t\t";

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: MyProfie(tabSpace: tabSpace));
  }
}

class MyProfie extends StatelessWidget {
  const MyProfie({
    Key? key,
    required this.tabSpace,
  }) : super(key: key);

  final String tabSpace;

  @override
  Widget build(BuildContext context) {
    final jsonString = Global.storgeServece.getStringData("STUDEN_DATA");
    late SingUpModel student;
    if (jsonString != null) {
      final decodeJsonData = json.decode(jsonString);
      student = SingUpModel.formJson(decodeJsonData);
    }
    return Container(
      color: AppColors.backgroundPages,
      child: Stack(children: [
        DarkRadialBackground(
          color: AppColors.backgroundPages,
          position: "topLeft",
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DefaultNav(
                    title: "$tabSpace ",
                  ),
                  SizedBox(height: 30),
                  ProfileDummy(
                      color: HexColor.fromHex("94F0F1"),
                      dummyType: ProfileDummyType.image,
                      scale: 4.0,
                      image: student.image),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${student.name}",
                        style: GoogleFonts.almarai(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold)),
                  ),
                  Text("${student.email}",
                      style: GoogleFonts.lato(
                          color: HexColor.fromHex("B0FFE1"), fontSize: 17)),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: OutlinedButtonWithText(
                        width: 75,
                        content: "تعديل",
                        onPressed: () {
                          // Get.to(() => EditProfilePage());
                        }),
                  ),
                  AppSpaces.verticalSpace20,
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF262A34),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            // ToggleLabelOption(
                            //   label: '$tabSpace Show me as away',
                            //   notifierValue: totalTaskNotifier,
                            //   icon: Icons.directions_run_rounded,
                            //   margin: 7.0,
                            // ),
                          ],
                        ),
                      ),
                      AppSpaces.verticalSpace10,
                      // ProfileTextOption(
                      //   label: '$tabSpace My Projects',
                      //   icon: Icons.cast,
                      //   margin: 5.0,
                      // ),
                      AppSpaces.verticalSpace10,
                      ProfileTextOption(
                        label: '$tabSpace Join Book Save',
                        icon: Icons.book_rounded,
                        margin: 5.0,
                      ),
                      AppSpaces.verticalSpace10,

                      ProfileTextOption(
                        label: '$tabSpace Join Link University',
                        icon: Icons.school_rounded,
                        margin: 5.0,
                      ),

                      AppSpaces.verticalSpace10,

                      GestureDetector(
                        onTap: () {
                          Global.storgeServece.setBool(
                              Constants.STORGE_DEVICE_OPEN_FIRST_TIME, false);
                          Global.storgeServece.setBool(
                              Constants.STORGE_USER_LOGED_FIRST, false);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => OnboardingCarousel()));
                        },
                        child: ProfileTextOption(
                          label: '$tabSpace Loge Oute',
                          icon: Icons.logout_rounded,
                          margin: 5.0,
                        ),
                      ),
                      // AppSpaces.verticalSpace10,
                      // ProfileTextOption(
                      //   label: '$tabSpace Share Profile',
                      //   icon: FeatherIcons.share2,
                      //   margin: 5.0,
                      // ),
                      // AppSpaces.verticalSpace10,
                      // ProfileTextOption(
                      //   label: '$tabSpace All My Task',
                      //   icon: Icons.check_circle_outline,
                      //   margin: 5.0,
                      // )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
