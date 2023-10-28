import 'package:flutter/material.dart';

import '../../../../../core/color/app_color.dart';
import '../../../../../core/constant/varibal.dart';
import '../../../domain/entites/header_books_entites.dart';
import '../Auth Widget/submet_login.dart';

Container BookOfTheDayCard(BuildContext context, List<Book> books, int index) {
  return Container(
    margin: EdgeInsets.only(top: 5, bottom: 20),
    width: appSize(context).width / 2 - 30,
    height: 245,
    child: Stack(
      children: <Widget>[
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.only(
              right: 24,
              top: 24,
              left: appSize(context).width * .35,
            ),
            height: 185,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 207, 201, 201).withOpacity(.5),
              borderRadius: BorderRadius.circular(29),
            ),
            child: Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(
                books[index].bookName.toString(),
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.kBlackColor,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          child:
//this use  when get image by net , this show clip radius and hero and cahed imag by pakege cashed and show palceholder image

              //  ClipRRect(
              //   borderRadius: BorderRadius.all(Radius.circular(20)),
              //   child: InteractiveViewer(
              //     clipBehavior: Clip.hardEdge,
              //     child: Hero(
              //       tag: "",
              //       child: CachedNetworkImage(
              //         placeholder: (context, _) =>
              //             const CircularProgressIndicator(),
              //         imageUrl: "",
              //         fit: BoxFit.cover,
              //       ),
              //     ))),

              Image.asset(
            books[index].imgBook.toString(),
            width: appSize(context).width * .34,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: SizedBox(
              height: 40,
              width: appSize(context).width * .468,
              child: SubmitFormBtn(
                btnName: 'Download',
                onPressed: () {},
              )),
        ),
        Text(
          "",
          // "When the earth was flat and everyone wanted to win the game of the best and people….",
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.primaryAccentColor,
          ),
        ),
      ],
    ),
  );
}
