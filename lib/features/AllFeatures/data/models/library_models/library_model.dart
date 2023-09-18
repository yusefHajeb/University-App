import '../../../domain/entites/header_books_entites.dart';

class LibraryModel extends BookDetaile {
  LibraryModel(
      {int? id,
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
            subject: subject);

  factory LibraryModel.formJson(Map<String, dynamic> data) {
    return LibraryModel(
        id: data['id'] as int,
        category_id: data['category_id'] as int,
        patch_id: data['patch_id'] as int,
        img_book: data['img_book'] as String,
        name_book: data['name_book'] as String,
        pdfUrl: data['pdfUrl'] as String,
        subject: data['subject'] ?? "",
        write_book: data['write_book'] ?? "");
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
    };
  }
}

class BookTitleModel extends CategoryBooks {
  BookTitleModel({String? book_title, int? bookId})
      : super(book_title: book_title, book_id: bookId);
}
