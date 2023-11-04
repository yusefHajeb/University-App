import '../../../domain/entites/header_books_entites.dart';

class BookModel extends Book {
  const BookModel(
      {int? courseId,
      int? tId,
      String? type,
      String? imgBook,
      String? bookName,
      String? bookAuther,
      String? pdfUrl})
      : super(
          courseId: courseId,
          imgBook: imgBook,
          pdfUrl: pdfUrl,
          bookName: bookName,
          bookAuthor: bookAuther,
          bookType: type,
          tId: tId,
        );

  BookModel copyWith({
    int? courseId,
    String? bookAuther,
    String? bookImage,
    String? bookName,
    String? pdfUrl,
    String? bookType,
    int? tId,
  }) {
    return BookModel(
        type: bookType ?? this.bookType,
        bookAuther: bookAuther ?? this.bookAuthor,
        courseId: courseId ?? this.courseId,
        imgBook: bookImage ?? this.imgBook,
        bookName: bookName ?? this.bookName,
        pdfUrl: pdfUrl ?? this.pdfUrl,
        tId: tId ?? this.tId);
  }

  factory BookModel.formJson(Map<String, dynamic> data) {
    return BookModel(
      courseId: data[LibraryKeys.courseId] as int?,
      imgBook: data[LibraryKeys.bookImage] as String?,
      bookName: data[LibraryKeys.bookName] as String?,
      pdfUrl: data[LibraryKeys.bookUrl] as String?,
      bookAuther: data[LibraryKeys.bookAuthor] as String?,
      type: data[LibraryKeys.bookType] as String?,
      tId: data[LibraryKeys.tId] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      LibraryKeys.courseId: courseId,
      LibraryKeys.bookImage: imgBook,
      LibraryKeys.bookName: bookName,
      LibraryKeys.bookUrl: pdfUrl,
      LibraryKeys.bookAuthor: bookAuthor,
      LibraryKeys.bookType: bookType,
      LibraryKeys.tId: tId,
    };
  }
}

class BookTitleModel extends CategoryBooks {
  BookTitleModel({String? book_title, int? bookId})
      : super(book_title: book_title, book_id: bookId);

  Map<String, dynamic> toJson() {
    return {"coures_name": book_title, "t_id": book_id};
  }

  factory BookTitleModel.formJson(Map<String, dynamic> data) {
    return BookTitleModel(
      bookId: data['t_id'] ?? 1,
      book_title: data['coures_name'] ?? "",
    );
  }
}

class Library {
  final List<BookModel> libraryModel;
  final List<BookTitleModel> bookTitleModel;

  Library({required this.libraryModel, required this.bookTitleModel});
}

class LibraryKeys {
  static const String courseId = "coures_id";
  static const String bookName = "book_name";
  static const String bookType = "book_type";
  static const String bookImage = "book_img";
  static const String bookAuthor = "book_author";
  static const String bookUrl = "book_url";
  static const String tId = "t_id";
}


//  RowDataPacket {
//     t_id: 6,
//     day_id: 1,
//     dept_name: 'رياضيات الحاسوب',
//     level_name: 'المستوى الثاني الترم الثاني',
//     coures_name: 'اساسيات برمجة',
//     time_name: 'الثالثة',
//     classroom_name: 'معلم علوم',
//     batch_name: 'الرؤية التقنية',
//     start_year: 2023-10-05T21:00:00.000Z,
//     instructor_name: 'رشيد الشعيبي'
//   }