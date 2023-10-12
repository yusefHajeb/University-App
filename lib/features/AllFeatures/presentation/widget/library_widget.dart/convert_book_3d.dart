import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/features/AllFeatures/presentation/bloc/book_favorite_bloc/books_favorite_bloc.dart';
// import 'package:university/features/AllFeatures/presentation/widget/Auth%20Widget/submet_login.dart';

import '../../../../../core/color/app_color.dart';
import '../../../data/models/library_models/library_model.dart';
import '../../pages/library/downoad_widget.dart';
// import '../../../../../core/constant/varibal.dart';
// import '../../../../../core/widget/buttons/button_back.dart';
// import '../../../../../core/widget/buttons/custom_button_with_icon.dart';
// import '../../../../../core/widget/buttons/default_back.dart';

// class BookCover3D extends StatefulWidget {
//   final String imageUrl;

//   BookCover3D({
//     required this.imageUrl,
//   });

//   @override
//   State<BookCover3D> createState() => _BookCover3DState();
// }

class BookCover3D extends StatelessWidget {
  final bool confige;
  final LibraryModel book;
  const BookCover3D({super.key, required this.book, required this.confige});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 200,
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(2, 2, 0.001)
          ..rotateY(0.25),
        alignment: FractionalOffset.center,
        child: Stack(
          // physics: NeverScrollableScrollPhysics(),
          // scrollDirection: Axis.vertical,
          // shrinkWrap: true,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AspectRatio(
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
                    imageUrl: book.img_book.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
                top: 2,
                // bottom: 2,
                child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 240, 240),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    width: 20,
                    height: 20,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.favorite,
                      size: 14,
                      color: AppColors.error.withAlpha(300),
                    )

                    // IconButton(
                    )),
            Positioned(
                bottom: 2,

                // bottom: 2,
                child: TestDownload(
                  bookDownload: book,
                ))
          ],
        ),
      ),
    );
  }
}
