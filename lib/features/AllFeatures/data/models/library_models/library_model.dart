import '../../../domain/entites/header_books_entites.dart';

class LibraryModel extends BookDetaile {
  LibraryModel(
      {int? id,
      bool? isDownload,
      int? category_id,
      int? patch_id,
      String? subject,
      String? img_book,
      String? name_book,
      String? write_book,
      String? pdfUrl})
      : super(
            id: id,
            category_id: category_id,
            patch_id: patch_id,
            img_book: img_book,
            pdfUrl: pdfUrl,
            subject: subject,
            isDownload: isDownload);
  factory LibraryModel.formJson(Map<String, dynamic> data) {
    return LibraryModel(
        id: data['id'] as int?,
        category_id: data['category_id'] as int?,
        patch_id: data['patch_id'] as int?,
        img_book: data['img_book'] as String?,
        name_book: data['name_book'] as String?,
        pdfUrl: data['pdfUrl'] as String?,
        subject: data['subject'] as String?,
        write_book: data['write_book'] as String?,
        isDownload: data['isDownload'] as bool?);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': category_id,
      'patch_id': patch_id,
      'img_book': img_book,
      'name_book': name_book,
      'subject': subject,
      'pdfUrl': pdfUrl,
      'write_book': write_book,
      'isDownload': isDownload
    };
  }
}

class BookTitleModel extends CategoryBooks {
  BookTitleModel({String? book_title, int? bookId})
      : super(book_title: book_title, book_id: bookId);

  Map<String, dynamic> toJson() {
    return {"book_title": book_title, "book_id": book_id};
  }

  factory BookTitleModel.formJson(Map<String, dynamic> data) {
    return BookTitleModel(
      bookId: data['book_id'] ?? 1,
      book_title: data['book_title'] ?? "",
    );
  }
}

class Library {
  final List<LibraryModel> libraryModel;
  final List<BookTitleModel> bookTitleModel;

  Library({required this.libraryModel, required this.bookTitleModel});
}
