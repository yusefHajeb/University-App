import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/Utils/box_decoration.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/core/value/app_space.dart';
import 'package:university/core/widget/loading_widget.dart';

import 'package:university/features/AllFeatures/domain/entites/header_books_entites.dart';
import '../../../../core/color/app_color.dart';
import '../../../../core/value/style_manager.dart';
import '../../../../core/widget/bakground_dark.dart';
import '../../../../core/widget/buttons/custom_button_with_icon.dart';
import '../../../../core/widget/buttons/default_back.dart';
import '../bloc/book_favorite_bloc/books_favorite_bloc.dart';
import '../widget/library_widget.dart/reading_book.dart';

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
                  const DefaultNav(title: "\t\t\t المفضلة"),
                  AppSpaces.verticalSpace20,
                  BlocBuilder<DownloadBooksBloc, DownlaodBooksState>(
                    builder: (context, state) {
                      if (state is LoadingBookSatate) {
                        return LoadingCircularProgress();
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          print(state.favrit.length);
                          return InkWell(
                              child:
                                  CardBookSave(context, state.favrit[index]));
                        },
                        itemCount: state.favrit.length,
                      );
                    },
                  ),
                  AppSpaces.verticalSpace20,
                ]))))
          ])),
    );
  }

  Container CardBookSave(
    BuildContext context,
    BookDetaile favorite,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(3),
      width: double.infinity,
      height: 130,
      decoration: BoxDecorationStyles.testStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: appSize(context).width / 5,
            child: AspectRatio(
              aspectRatio: 2 / 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(2.0, 4.0),
                      blurRadius: 3.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: favorite.img_book.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          AppSpaces.horizontalSpace20,
          InkWell(
            onTap: () {
              File filePath = File("${favorite.pdfUrl}");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ReadingBook(
                    file: filePath,
                  ),
                ),
              );
            },
            child: Container(
              width: appSize(context).width / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text("اسم الكتاب",
                          style: getFontNormal(
                              22, FontWeight.w600, AppColors.white)),
                    ],
                  ),
                  AppSpaces.verticalSpace10,
                  Row(
                    children: [
                      Text(
                        "تصنيف :",
                        style:
                            getFontNormal(15, FontWeight.w600, AppColors.white),
                      ),
                      AppSpaces.horizontalSpace10,
                      Text(
                        favorite.subject.toString(),
                        style: getFontNormal(
                            13, FontWeight.normal, AppColors.greyColor),
                      )
                    ],
                  ),
                  AppSpaces.verticalSpace10,
                  Row(
                    children: [
                      Text(
                        "المؤلف:",
                        style:
                            getFontNormal(15, FontWeight.w600, AppColors.white),
                      ),
                      AppSpaces.horizontalSpace10,
                      Text(
                        favorite.subject.toString(),
                        style: getFontNormal(
                            13, FontWeight.normal, AppColors.greyColor),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          AppSpaces.horizontalSpace10,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  File filePath = File("${favorite.pdfUrl}");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReadingBook(
                        file: filePath,
                      ),
                    ),
                  );
                },
                child: Container(
                  child: const RoundedBorderWithIcon(
                    icon: Icons.file_open_rounded,
                    color: Color.fromARGB(255, 36, 84, 146),
                  ),
                ),
              ),
              AppSpaces.verticalSpace5,
              InkWell(
                onTap: () {
                  context
                      .read<DownloadBooksBloc>()
                      .add(DeleteFavorites(index: favorite.id ?? 0));
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
                onTap: () async {},
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
  }
}
