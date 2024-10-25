import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:university/core/constant/varibal.dart';
// import 'package:university/features/AllFeatures/presentation/widget/Auth%20Widget/submet_login.dart
import '../../../data/models/library_models/library_model.dart';
import '../../pages/library/downoad_widget.dart';

class BookCover3D extends StatelessWidget {
  final bool confige;
  final BookModel book;
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
          children: [
            AspectRatio(
              aspectRatio: 2 / 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(96, 185, 185, 185),
                      offset: Offset(2.0, 4.0),
                      blurRadius: 3.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl:
                        Constants.imageBooksRoute + book.imgBook.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
                left: 15,
                // bottom: -8,
                bottom: -4,
                child: Wrap(children: [
                  TestDownload(
                    bookDownload: book,
                  ),
                ]))
          ],
        ),
      ),
    );
  }
}
