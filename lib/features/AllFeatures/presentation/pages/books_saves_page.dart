import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/Utils/box_decoration.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/core/value/app_space.dart';
import '../../../../core/color/app_color.dart';
import '../../../../core/value/style_manager.dart';
import '../../../../core/widget/bakground_dark.dart';
import '../../../../core/widget/buttons/custom_button_with_icon.dart';
import '../../../../core/widget/buttons/default_back.dart';
import '../../../../core/widget/dummy/profile_dummy.dart';
import '../bloc/book_favorite_bloc/books_favorite_bloc.dart';

class BooksDownloaded extends StatelessWidget {
  const BooksDownloaded({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          height: appSize(context).height,
          color: AppColors.backgroundPages,
          child: Stack(children: [
            DarkRadialBackground(
              color: AppColors.backgroundPages,
              position: "topLeft",
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: SizedBox(
                    child: SingleChildScrollView(
                        child: Column(children: [
                  DefaultNav(title: "\t\t\t المفضلة"),
                  AppSpaces.verticalSpace20,
                  BlocBuilder<BooksFavoriteBloc, BooksFavoriteState>(
                    builder: (context, state) {
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            // clipper: ,
                            // clipBehavior: ,
                            margin: EdgeInsets.only(bottom: 20),
                            padding: EdgeInsets.all(3),
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecorationStyles.testStyle,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: appSize(context).width / 5,
                                  child: Container(
                                    // width: 60,
                                    // height: 120,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      child: Image.network(
                                          width: 40,
                                          fit: BoxFit.fill,
                                          state.favrit[index].img_book ?? ""),
                                    ),
                                  ),
                                ),
                                AppSpaces.horizontalSpace20,
                                Container(
                                  width: appSize(context).width / 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text("اسم الكتاب",
                                              style: getFontNormal(
                                                  22,
                                                  FontWeight.w600,
                                                  AppColors.white)),
                                        ],
                                      ),
                                      AppSpaces.verticalSpace10,
                                      Row(
                                        children: [
                                          Text(
                                            "تصنيف :",
                                            style: getFontNormal(
                                                15,
                                                FontWeight.w600,
                                                AppColors.white),
                                          ),
                                          AppSpaces.horizontalSpace10,
                                          Text(
                                            state.favrit[index].subject
                                                .toString(),
                                            style: getFontNormal(
                                                13,
                                                FontWeight.normal,
                                                AppColors.greyColor),
                                          )
                                        ],
                                      ),
                                      AppSpaces.verticalSpace10,
                                      Row(
                                        children: [
                                          Text(
                                            "المؤلف:",
                                            style: getFontNormal(
                                                15,
                                                FontWeight.w600,
                                                AppColors.white),
                                          ),
                                          AppSpaces.horizontalSpace10,
                                          Text(
                                            state.favrit[index].subject
                                                .toString(),
                                            style: getFontNormal(
                                                13,
                                                FontWeight.normal,
                                                AppColors.greyColor),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                AppSpaces.horizontalSpace10,
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: const RoundedBorderWithIcon(
                                        icon: Icons.file_open_rounded,
                                        color: Color.fromARGB(255, 36, 84, 146),
                                      ),
                                    ),
                                    AppSpaces.verticalSpace5,
                                    InkWell(
                                      onTap: () {
                                        context.read<BooksFavoriteBloc>().add(
                                            DeleteFavorites(
                                                index: state.favrit[index].id ??
                                                    0));
                                      },
                                      child: Container(
                                        child: RoundedBorderWithIcon(
                                          icon: Icons.delete_forever_rounded,
                                          color: AppColors.error,
                                        ),
                                      ),
                                    ),
                                    AppSpaces.verticalSpace5,
                                    InkWell(
                                      child: Container(
                                        child: RoundedBorderWithIcon(
                                          icon: Icons.share,
                                          color: AppColors.error,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: state.favrit.length,
                      );
                    },
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
