import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:university/core/widget/dummy/image_net.dart';

import '../../features/AllFeatures/data/models/auth_models/singup_model.dart';
import '../../features/AllFeatures/data/models/user_data.dart';
import '../../features/AllFeatures/presentation/bloc/authentication/authentication_bloc.dart';
import '../../features/AllFeatures/presentation/bloc/lading_page/lading_page_bloc.dart';
import '../../features/AllFeatures/presentation/pages/Auth/sing_in_page.dart';
import '../../features/AllFeatures/presentation/pages/profile/edite_data_user_page.dart';
import '../../features/AllFeatures/presentation/widget/profile_widget/text_autline.dart';
import '../Utils/box_decoration.dart';
import '../color/app_color.dart';
import '../constant/varibal.dart';
import '../fonts/app_fonts.dart';
import '../value/app_space.dart';
import '../value/global.dart';
import '../value/style_manager.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SingUpModel student = userDataModel();
    return Drawer(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            color: AppColors.backgroundPages,
            height: appSize(context).height / 3,
            child: DrawerHeader(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeIn,
              child: SizedBox(
                child: Column(
                  // alignment: WrapAlignment.center,
                  // crossAxisAlignment: WrapCrossAlignment.center,
                  // direction: Axis.vertical,
                  textDirection: TextDirection.rtl,
                  children: [
                    ProfileDummyNet(
                        color: HexColor.fromHex("94F0F1"),
                        dummyType: ProfileDummyTypeNet.image,
                        scale: 3.0,
                        image: Constants.imageRoute + student.image.toString()),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "${student.name}",
                        style: GoogleFonts.almarai(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text("${student.email}",
                        style: GoogleFonts.lato(
                            color: HexColor.fromHex("B0FFE1"), fontSize: 14)),
                    AppSpaces.verticalSpace5,
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: OutlinedButtonWithText(
                          width: 90,
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
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: appSize(context).height / 1.3,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecorationStyles.fadingGlory,
            child: SizedBox(
              // height: 300,
              child: ListView(shrinkWrap: true, children: <Widget>[
                Container(
                  decoration: BoxDecorationStyles.headerTab,
                  child: ListTile(
                    leading: Icon(
                      Icons.home_outlined,
                      color: AppColors.greyColor,
                    ),
                    title: Text(
                      'الرئيسية',
                      style: getFontNormal(
                          15, FontWeightManager.medium, AppColors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      context.read<LadingPageBloc>().add(TabChange(0));
                    },
                  ),
                ),
                AppSpaces.verticalSpace10,
                Container(
                  decoration: BoxDecorationStyles.headerTab,
                  child: ListTile(
                    leading: Icon(
                      Icons.account_box_outlined,
                      color: AppColors.greyColor,
                    ),
                    title: Text(
                      'عرض الملف الشخصي',
                      style: getFontNormal(
                          15, FontWeightManager.medium, AppColors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      context.read<LadingPageBloc>().add(TabChange(4));
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecorationStyles.headerTab,
                  child: ListTile(
                    leading: Icon(
                      Icons.mode_edit_outline,
                      size: 20,
                      color: AppColors.greyColor,
                    ),
                    title: Text(
                      'تعديل الملف الشخصي',
                      style: getFontNormal(
                          15, FontWeightManager.medium, AppColors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const EditeUserData(),
                          ));
                    },
                  ),
                ),
                AppSpaces.verticalSpace10,
                Container(
                  decoration: BoxDecorationStyles.headerTab,
                  child: ListTile(
                    leading: Icon(
                      Icons.download_for_offline_outlined,
                      color: AppColors.greyColor,
                    ),
                    title: Text(
                      'التنزيلات',
                      style: getFontNormal(
                          15, FontWeightManager.medium, AppColors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);

                      context.read<LadingPageBloc>().add(TabChange(2));
                    },
                  ),
                ),
                AppSpaces.verticalSpace10,
                Container(
                  decoration: BoxDecorationStyles.headerTab,
                  child: ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: AppColors.greyColor,
                    ),
                    title: Text(
                      'تسجيل الخروج',
                      style: getFontNormal(
                          15, FontWeightManager.medium, AppColors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);

                      Global.storgeServece.setBool(
                          Constants.STORGE_DEVICE_OPEN_FIRST_TIME, false);
                      // Global.storgeServece
                      //     .setBool(Constants.STORGE_USER_LOGED_FIRST, false);
                      Global.storgeServece.clear();
                      context.read<AuthenticationBloc>().add(AuthGetStart());
                      // .add(SetValueChange(value: 0));
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SingInPage(),
                          ),
                          (route) => false);
                    },
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
