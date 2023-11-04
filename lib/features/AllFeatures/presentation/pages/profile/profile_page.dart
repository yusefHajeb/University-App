// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/core/value/global.dart';
import 'package:university/core/value/style_manager.dart';
import 'package:university/features/AllFeatures/data/models/auth_models/singup_model.dart';
import 'package:university/features/AllFeatures/presentation/pages/profile/edite_data_user_page.dart';
import '../../../../../core/color/app_color.dart';
import '../../../../../core/value/app_space.dart';
import '../../../../../core/widget/bakground_dark.dart';
import '../../../data/models/user_data.dart';
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
    SingUpModel student = userDataModel();
    return Scaffold(
      backgroundColor: AppColors.backgrounfContent,
      body: Container(
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
                    Center(
                      child: Text(
                        "الملف الشخصي",
                        style:
                            getFontNormal(16, FontWeight.bold, AppColors.white),
                      ),
                    ),
                    SizedBox(height: 30),
                    // ProfileDummyNet(
                    //     color: HexColor.fromHex("94F0F1"),
                    //     dummyType: ProfileDummyTypeNet.image,
                    //     scale: 4.0,
                    //     image: student.image),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${student.name}",
                          style: GoogleFonts.almarai(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    ),
                    // FeatherIconData(FeatherIcons.activity)                    Icon(FeatherIcons.alertTriangle,
                    //     color: AppColors.white, size: 30),
                    Text("${student.email}",
                        style: GoogleFonts.lato(
                            color: HexColor.fromHex("B0FFE1"), fontSize: 17)),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: OutlinedButtonWithText(
                          width: 75,
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
                          label: '$tabSpace الانتقال الى الكتب المحفوظة',
                          icon: Icons.book_rounded,
                          margin: 5.0,
                        ),
                        AppSpaces.verticalSpace10,

                        ProfileTextOption(
                          label: '$tabSpace الذهاب الى الدردشة',
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

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => OnboardingCarousel(),
                                ),
                                (route) => false);
                          },
                          child: ProfileTextOption(
                            label: '$tabSpace تسجيل خروج',
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
      ),
    );
  }
}
