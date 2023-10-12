import 'package:equatable/equatable.dart';

class BookDetaile extends Equatable {
  final int? id;
  final int? category_id;
  final int? patch_id;
  final String? subject;
  final String? img_book;
  final String? name_book;
  final String? write_book;
  final String? pdfUrl;
  final bool? isDownload;

  const BookDetaile({
    this.isDownload,
    this.id,
    this.category_id,
    this.patch_id,
    this.subject,
    this.img_book,
    this.name_book,
    this.write_book,
    this.pdfUrl,
  });

  @override
  List<Object?> get props => [
        id,
        patch_id,
        subject,
        img_book,
        name_book,
        write_book,
        category_id,
        pdfUrl,
        isDownload
      ];
}

class CategoryBooks extends Equatable {
  final String? book_title;
  final int? book_id;
  CategoryBooks({required this.book_title, required this.book_id});

  @override
  // TODO: implement props
  List<Object?> get props => [book_title];
}
