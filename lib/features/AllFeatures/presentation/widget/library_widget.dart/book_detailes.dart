import 'package:flutter/material.dart';
import 'package:university/features/AllFeatures/domain/entites/header_books_entites.dart';

class BookDetailsBio extends StatelessWidget {
  const BookDetailsBio({Key? key, required this.book}) : super(key: key);

  final Book book;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                book.bookName.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            GestureDetector(
              onTap: () {
                // showDialog(
                //   context: context,
                //   builder: (BuildContext context) =>
                //       BarcodeBuilder(value: book.isbn),
                // );
              },
              child: const Icon(Icons.qr_code_2, size: 40),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "by ${book.bookAuthor}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black38,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          book.bookName.toString(),
        ),
      ],
    );
  }
}
