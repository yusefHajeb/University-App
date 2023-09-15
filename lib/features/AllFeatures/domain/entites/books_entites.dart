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
  BookDetaile({
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
        pdfUrl
      ];
}
