import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final int? tId;
  final int? courseId;
  final String? bookName;
  final String? imgBook;
  final String? bookAuthor;
  final String? pdfUrl;
  final String? bookType;
  const Book(
      {this.tId,
      this.courseId,
      this.bookName,
      this.imgBook,
      this.bookAuthor,
      this.pdfUrl,
      this.bookType});

  @override
  List<Object?> get props => [
        this.courseId,
        this.bookName,
        this.imgBook,
        this.bookAuthor,
        this.pdfUrl,
        this.bookType,
        this.tId,
      ];
}

class CategoryBooks extends Equatable {
  final String? book_title;
  final int? book_id;
  CategoryBooks({required this.book_title, required this.book_id});

  @override
  List<Object?> get props => [book_title, book_id];
}
