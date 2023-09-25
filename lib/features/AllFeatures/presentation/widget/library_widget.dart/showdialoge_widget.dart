import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/features/AllFeatures/presentation/bloc/book_favorite_bloc/books_favorite_bloc.dart';
import '../../../../../core/Utils/box_decoration.dart';
import '../../../../../core/constant/varibal.dart';
import '../../../../../core/value/app_space.dart';
import '../../../domain/entites/header_books_entites.dart';
import '../Auth Widget/submet_login.dart';

funcShow(BuildContext context, BookDetaile list) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            decoration: BoxDecorationStyles.fadingInnerDecor,
            width: appSize(context).width - 20,
            height: appSize(context).height / 2 - 60,
            // color: AppColors.white,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    // padding: EdgeInsets.all(10),
                    width: double.infinity,
                    // height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Image.asset(
                        list.img_book.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                AppSpaces.verticalSpace10,
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: Text("اسم الكتاب")),
                      Expanded(child: Text(list.name_book.toString()))
                    ],
                  ),
                ),
                AppSpaces.verticalSpace10,
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: Text("مؤلف الكتاب")),
                      Expanded(child: Text(list.subject.toString()))
                    ],
                  ),
                ),
                AppSpaces.horizontalSpace20,
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: SubmitFormBtn(
                      btnName: "Download",
                      onPressed: () {
                        BlocProvider.of<BooksFavoriteBloc>(context)
                            .add(StartDownloadEvent(book: list));
                      },
                    ),
                  ),
                ),
                AppSpaces.verticalSpace10,
              ],
            ),
          ),
        );
      });
}
