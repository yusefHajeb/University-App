import 'package:flutter/material.dart';
import 'package:university/features/AllFeatures/presentation/widget/library_widget.dart/reading_book.dart';

import 'convert_book_3d.dart';

class LastOpenedBook extends StatelessWidget {
  const LastOpenedBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Opened Lastly  ",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReadingBook(
                          pdfPath: "assets/pdf/harry_potter.pdf",
                        )),
              );
            },
            child: BookCover3D(
              url:
                  "https://m.media-amazon.com/images/I/418HLIXlxCL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg",
              confige: true,
            ),
          ),
        ),
      ],
    );
  }
}
