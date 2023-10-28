import 'dart:convert';
import 'package:university/core/error/failure.dart';
import 'package:university/features/AllFeatures/data/models/library_models/library_model.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/constant/varibal.dart';
import '../data_access.dart';

abstract class LibraryRemoteDataSource {
  Future<Library> getAllBooks();
  Future<List<BookTitleModel>> getTitleBooks();
  Future<List<BookModel>> getBooks();
}

class LibraryRemoteDataSourceImp implements LibraryRemoteDataSource {
  // final http.Client client;
  final http.Client client;
  LibraryRemoteDataSourceImp({required this.client});

  @override
  Future<Library> getAllBooks() async {
    // String respone = """
    // {
    // "books": [
    // {
    // "id": 1,
    // "category_id": 1,
    // "patch_id": 2,
    // "subject": "شبكات",
    // "img_book": "https://m.media-amazon.com/images/I/41pTqRlersL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg",
    // "name_book": "Clean advanced",
    // "write_book": "Yousef Hajeb",
    // "pdfUrl": "https://m.media-amazon.com/images/I/41pTqRlersL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg"
    // },
    // {
    // "id": 2,
    // "category_id": 3,
    // "patch_id": 2,
    // "subject": "نطبيقات ذكاء اصطناعي",
    // "img_book":"https://m.media-amazon.com/images/I/41HvCijjVbL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg" ,
    // "name_book": "PHP form beginer to advanced",
    // "write_book": "Yousef Hajeb",
    // "pdfUrl": "https://www.fluttercampus.com/sample.pdf"
    // },
    // {
    // "id": 3,
    // "category_id": 3,
    // "patch_id": 2,
    // "subject": "تطبيقات ويب",
    // "img_book": "https://m.media-amazon.com/images/I/41zWWzbiHpL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg",
    // "name_book": "ابي الجميل",
    // "write_book": "Yousef Hajeb",
    // "pdfUrl": "https://www.fluttercampus.com/sample.pdf"
    // },
    // {
    // "id": 4,
    // "category_id": 3,
    // "patch_id": 2,
    // "subject": "تطبيقات ويب",
    // "img_book": "https://m.media-amazon.com/images/I/41zWWzbiHpL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg",
    // "name_book": "ابي الجميل",
    // "write_book": "Yousef Hajeb",
    // "pdfUrl": "https://www.fluttercampus.com/sample.pdf"
    // },
    // {
    // "id": 4,
    // "category_id": 3,
    // "patch_id": 2,
    // "subject": "تطبيقات ويب",
    // "img_book": "https://m.media-amazon.com/images/I/41zWWzbiHpL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg",
    // "name_book": "ابي الجميل",
    // "write_book": "Yousef Hajeb",
    // "pdfUrl": "https://www.fluttercampus.com/sample.pdf"
    // },
    // {
    // "id": 1,
    // "category_id": 5,
    // "patch_id": 2,
    // "subject": "شبكات",
    // "img_book": "https://m.media-amazon.com/images/I/41pTqRlersL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg",
    // "name_book": "Clean advanced",
    // "write_book": "Yousef Hajeb",
    // "pdfUrl": "https://m.media-amazon.com/images/I/41pTqRlersL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg"
    // }
    //
    // ],
    // "headers": [
    // {
    // "book_title": "الكل",
    // "bookId": 1
    // },
    // {
    // "book_title": "شبكات",
    // "bookId": 2
    // },
    // {
    // "book_title": "نطبيقات ذكاء اصطناعي",
    // "bookId": 3
    // },
    // {
    // "book_title": "تطبيقات ويب",
    // "bookId": 4
    // },
    // {
    // "book_title": "حوسبة سحابية",
    // "bookId": 3
    // },
    // {
    // "book_title": "برمجة كائنية",
    // "bookId": 4
    // },
    // {
    // "book_title": "ادارة مشاريع",
    // "bookId": 3
    // }
    // ]
    // }
// """;

//     final Map<String, dynamic> jsonData = await jsonDecode(respone);

// // localCash.cachBooks(jsonDecode(respone));
//     List<BookModel> books =
//         (jsonData['books'] as List).map((e) => BookModel.formJson(e)).toList();

//     List<BookTitleModel> header = (jsonData['headers'] as List)
//         .map((e) => BookTitleModel.formJson(e))
//         .toList();

//     Library(libraryModel: books, bookTitleModel: header);
//     return Library(libraryModel: books, bookTitleModel: header);
//=================================================================
    print(" ===============");

    Crud curd = new Crud();

    var response = await curd.PostRequset(Constants.libraryLink, {
      "batch_id": '${12}',
    });
    if (response["status"] == "success") {
      final List dataBook = response["data"];
      final List<BookModel> booksModel = dataBook
          .map((jsonPostModel) => BookModel.formJson(jsonPostModel))
          .toList();

      //=========header
      List dataCourse = response['headers'];
      final List<BookTitleModel> courseModel = dataCourse
          .map((jsonPostModel) => BookTitleModel.formJson(jsonPostModel))
          .toList();
      Library courseAndBooks =
          Library(libraryModel: booksModel, bookTitleModel: courseModel);
      return courseAndBooks;
    } else {
      print("no respons? ");
      throw ServerFailure();
    }

    ///================ with conection enternet
    // final responce = await client.post(Uri.parse(Constants.library), body: {});
    // if (responce.statusCode == 200) {
    //   final List responseData = jsonDecode(responce.body) as List;

    //   final List<LibraryModel> modelsLibrary = responseData
    //       .map((jsonLibrary) => LibraryModel.formJson(jsonLibrary))
    //       .toList();
    //   return modelsLibrary;
    // } else {
    //   throw ServerException();
    // }

    //============end connection
  }

  @override
  Future<List<BookTitleModel>> getTitleBooks() async {
    // final response = await client.post(Uri.parse(Constants.schedule));
    String header = """[
            {
                "book_title": "الكل",
                "bookId": 1
            },
            {
                "book_title": "شبكات",
                "bookId": 2
            },
            {
                "book_title": "نطبيقات ذكاء اصطناعي",
                "bookId": 3
            },
            {
                "book_title": "تطبيقات ويب",
                "bookId": 4
            },
            {
                "book_title": "حوسبة سحابية",
                "bookId": 3
            },
            {
                "book_title": "برمجة كائنية",
                "bookId": 4
            },
            {
                "book_title": "ادارة مشاريع",
                "bookId": 3
            }
        ]""";

    final List jsonData = await jsonDecode(header);
    List<BookTitleModel> course = [];
    List<BookTitleModel> bookHeader =
        (jsonData as List).map((e) => BookTitleModel.formJson(e)).toList();

    for (var item in jsonData) {
      course.add(BookTitleModel.formJson(item));
    }
    return course;
    // localCash.cachBooks(jsonDecode(respone));
  }

  @override
  Future<List<BookModel>> getBooks() async {
    String jsonBook = """  [
            {
                "id": 1,
                "category_id": 1,
                "patch_id": 2,
                "subject": "شبكات",
                "img_book": "https://m.media-amazon.com/images/I/41pTqRlersL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg",
                "name_book": "Clean advanced",
                "write_book": "Yousef Hajeb",
                "pdfUrl": "https://m.media-amazon.com/images/I/41pTqRlersL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg"
            },
            {
                "id": 2,
                "category_id": 3,
                "patch_id": 2,
                "subject": "نطبيقات ذكاء اصطناعي",
                "img_book":"https://m.media-amazon.com/images/I/41HvCijjVbL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg" ,
                "name_book": "PHP form beginer to advanced",
                "write_book": "Yousef Hajeb",
                "pdfUrl": "https://www.fluttercampus.com/sample.pdf"
            },
            {
                "id": 3,
                "category_id": 3,
                "patch_id": 2,
                "subject": "تطبيقات ويب",
                "img_book": "https://m.media-amazon.com/images/I/41zWWzbiHpL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg",
                "name_book": "ابي الجميل",
                "write_book": "Yousef Hajeb",
                "pdfUrl": "https://www.fluttercampus.com/sample.pdf"
            },
            {
                "id": 4,
                "category_id": 3,
                "patch_id": 2,
                "subject": "تطبيقات ويب",
                "img_book": "https://m.media-amazon.com/images/I/41zWWzbiHpL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg",
                "name_book": "ابي الجميل",
                "write_book": "Yousef Hajeb",
                "pdfUrl": "https://www.fluttercampus.com/sample.pdf"
            },
            {
                "id": 4,
                "category_id": 3,
                "patch_id": 2,
                "subject": "تطبيقات ويب",
                "img_book": "https://m.media-amazon.com/images/I/41zWWzbiHpL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg",
                "name_book": "ابي الجميل",
                "write_book": "Yousef Hajeb",
                "pdfUrl": "https://www.fluttercampus.com/sample.pdf"
            },
            {
                "id": 1,
                "category_id": 5,
                "patch_id": 2,
                "subject": "شبكات",
                "img_book": "https://m.media-amazon.com/images/I/41pTqRlersL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg",
                "name_book": "Clean advanced",
                "write_book": "Yousef Hajeb",
                "pdfUrl": "https://m.media-amazon.com/images/I/41pTqRlersL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg"
            }
           
        ],""";
    final Map<String, dynamic> jsonData = await jsonDecode(jsonBook);

// localCash.cachBooks(jsonDecode(respone));
    List<BookModel> books =
        (jsonData['books'] as List).map((e) => BookModel.formJson(e)).toList();

    return books;
  }
}
