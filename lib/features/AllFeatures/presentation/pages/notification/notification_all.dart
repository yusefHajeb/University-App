import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:university/core/Utils/box_decoration.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/core/fonts/app_fonts.dart';
import 'package:university/core/value/app_space.dart';
import 'package:university/core/widget/buttons/custom_button_with_icon.dart';
import 'package:university/core/widget/flutter_toast.dart';
import 'package:university/features/AllFeatures/presentation/resources/assets_mananger.dart';
import '../../../../../core/color/app_color.dart';
import '../../../../../core/value/style_manager.dart';
import '../../../../../core/widget/bakground_dark.dart';
import '../../../../../core/widget/dummy/notification_widget.dart';
import '../../../data/models/user_data.dart';
// import '../../bloc/book_favorite_bloc/books_favorite_bloc.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});
  void shareFile(String filePath) async {
    print("shareFile");
    // print(filePath);
    String path = File(filePath).path;
    print(path);
    final result = await Share.shareXFiles([XFile('${filePath}')],
        subject: "ملف من تطبيق جامعتي");

    if (result.status == ShareResultStatus.success) {
      toastInfo(msg: "تم ارسال الكتاب بنجاح");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: appSize(context).height,
        color: AppColors.backgroundPages,
        child: Stack(
          children: [
            DarkRadialBackground(
              color: AppColors.backgroundPages,
              position: "topLeft",
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppSpaces.verticalSpace20,
                      Text(
                        "التنزيلات",
                        style: getFontNormal(
                          17,
                          FontWeight.bold,
                          AppColors.bottomHeaderColor,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        height: appSize(context).height / 2,
                        decoration: BoxDecorationStyles.testStyle,
                        child: Wrap(
                          direction: Axis.vertical,
                          alignment: WrapAlignment.start,
                          children: [
                            Container(
                              width: appSize(context).width / 1.2,
                              height: 200,
                              // decoration: BoxDecorationStyles.testStyle,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                // borderRadius: BorderRadiusGeometry.  ,
                                child: Image.asset(
                                    fit: BoxFit.cover,
                                    // height: 40,
                                    ImageAssets.imageOne),
                              ),
                            ),
                            AppSpaces.verticalSpace10,
                            Wrap(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.spaceAround,

                              // crossAxisAlignment: WrapCrossAlignment.spaceBetween,
                              children: [
                                // const RoundedBorderWithIcon(
                                //     icon: Icons.read_more),
                                // AppSpaces.horizontalSpace20,

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 100,
                                      decoration:
                                          BoxDecorationStyles.fadingInnerDecor,
                                      child: Text(
                                        "تسديد رسوم",
                                        textAlign: TextAlign.center,
                                        style: getFontNormal(
                                            13,
                                            FontWeightManager.bold,
                                            AppColors.backgroundPages),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                          "بالاشارة الى الموضوع اعلاة نود تنبيهكم بضرورة سرعة تسديد الرسوم الدراسية شاكرين حسن استجابتكم"),
                                    ),
                                    Container(
                                      width: 100,
                                      decoration:
                                          BoxDecorationStyles.fadingInnerDecor,
                                      child: Text(
                                        "تسديد رسوم",
                                        textAlign: TextAlign.center,
                                        style: getFontNormal(
                                            13,
                                            FontWeightManager.bold,
                                            AppColors.backgroundPages),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        height: 600,
                        // height: 400,
                        // decoration: BoxDecorationStyles.testStyle,
                        child: Container(
                          height: 200,
                          padding: EdgeInsets.only(right: 10),
                          decoration: BoxDecorationStyles.fadingGlory,
                          child: ClipRRect(
                            clipBehavior: Clip.antiAlias,
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                                // fit: BoxFit.cover,

                                height: 40,
                                ImageAssets.imageOne),
                          ),
                        ),
                      ),
                      AppSpaces.verticalSpace20,
                      // ...notificationCards,
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          // print(state.favrit.length);
                          return Container();
                        },
                        itemCount: 2,
                      ),
                      AppSpaces.verticalSpace20,
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
