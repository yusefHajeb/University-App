// import 'package:flutter/material.dart';
// import 'package:university/features/AllFeatures/presentation/widget/library_widget.dart/reading_book.dart';
// import '../../../domain/entites/header_books_entites.dart';
// import 'convert_book_3d.dart';

// // ignore: must_be_immutable
// class KeepReadingSection extends StatelessWidget {
//   List<BookDetaile> books;
//   KeepReadingSection({Key? key, required this.books}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "استمر بالقراءة ",
//           style: Theme.of(context).textTheme.titleSmall,
//         ),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: _buildPopularBookList(context, books),
//           ),
//         ),
//       ],
//     );
//   }

//   List<Widget> _buildPopularBookList(
//       BuildContext context, List<BookDetaile> books) {
//     // final List<Book> books = getAllBooks();

//     return books.skip(12).take(5).map((book) {
//       return Padding(
//         padding: const EdgeInsets.only(right: 20.0),
//         child: GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ReadingBook(
//                   pdfPath: "assets/pdf/harry_potter.pdf",
//                 ),
//               ),
//             );
//           },
//           child: BookCover3D(
//             url: book.img_book ?? "",
//             confige: true,
//           ),
//         ),
//       );
//     }).toList();
//   }
// }
