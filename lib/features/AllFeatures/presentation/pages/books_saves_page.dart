import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:university/core/Utils/box_decoration.dart';
import 'package:university/core/value/app_space.dart';
import 'package:university/features/AllFeatures/presentation/pages/application_page.dart';

import '../../../../core/color/app_color.dart';
import '../../../../core/widget/bakground_dark.dart';
import '../../../../core/widget/buttons/default_back.dart';
import '../../../../core/widget/dummy/profile_dummy.dart';

class BooksDownloaded extends StatelessWidget {
  const BooksDownloaded({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
                        child: Column(children: [
                  DefaultNav(title: "\t\t\t المفضلة"),
                  AppSpaces.verticalSpace20,
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        // clipper: ,
                        // clipBehavior: ,
                        margin: EdgeInsets.only(bottom: 20),
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        height: 100,
                        child: Container(),
                        decoration: BoxDecorationStyles.testStyle,
                      );
                    },
                    itemCount: 8,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    height: 100,
                    child: Container(),
                    decoration: BoxDecorationStyles.cardSchedule,
                  ),
                  AppSpaces.verticalSpace20,
                  ProfileDummy(
                      color: HexColor.fromHex("94F0F1"),
                      dummyType: ProfileDummyType.image,
                      scale: 4.0,
                      image: "assets/images/slider-background-3.png"),
                ]))))
          ])),
    );
  }
}
