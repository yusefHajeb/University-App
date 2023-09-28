import 'dart:convert';
import 'package:university/core/constant/varibal.dart';
import 'package:university/core/value/global.dart';
import 'package:university/features/AllFeatures/data/datasource/library/library_local_data.dart';
import 'package:university/features/AllFeatures/data/models/library_models/library_model.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/network/check_network.dart';

abstract class LibraryRemoteDataSource {
  Future<Library> getAllBooks();
  Future<BookTitleModel> getTitleBooks();
}

class LibraryRemoteDataSourceImp implements LibraryRemoteDataSource {
  // final http.Client client;
  final http.Client client;
  LibraryRemoteDataSourceImp({required this.client});

  @override
  Future<Library> getAllBooks() async {
    String respone = """
    {
        "books": [
            {
                "id": 2,
                "category_id": 1,
                "patch_id": 2,
                "subject": "شبكات",
                "img_book": "assets/images/7.jpg",
                "name_book": "Clean advanced",
                "write_book": "Yousef Hajeb",
                "pdfUrl": "https://m.media-amazon.com/images/I/41pTqRlersL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg"
            },
            {
                "id": 2,
                "category_id": 3,
                "patch_id": 2,
                "subject": "نطبيقات ذكاء اصطناعي",
                "img_book": "assets/images/5.jpg",
                "name_book": "PHP form beginer to advanced",
                "write_book": "Yousef Hajeb",
                "pdfUrl": "https://m.media-amazon.com/images/I/41HvCijjVbL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg"
            },
            {
                "id": 2,
                "category_id": 3,
                "patch_id": 2,
                "subject": "تطبيقات ويب",
                "img_book": "assets/images/4.jpg",
                "name_book": "ابي الجميل",
                "write_book": "Yousef Hajeb",
                "pdfUrl": "https://m.media-amazon.com/images/I/41zWWzbiHpL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg"
            },
            {
                "id": 2,
                "category_id": 3,
                "patch_id": 2,
                "subject": "تطبيقات ويب",
                "img_book": "assets/images/4.jpg",
                "name_book": "ابي الجميل",
                "write_book": "Yousef Hajeb",
                "pdfUrl": "https://m.media-amazon.com/images/I/41zWWzbiHpL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg"
            }
           
        ],
        "headers": [
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
        ]
    }
""";

    final Map<String, dynamic> jsonData = await jsonDecode(respone);
    LibraryLocalDataSource localCash;
// localCash.cachBooks(jsonDecode(respone));
    List<LibraryModel> books = (jsonData['books'] as List)
        .map((e) => LibraryModel.formJson(e))
        .toList();

    // print(jsonData);
    // for (var item in jsonData) {
    //   books.add(LibraryModel.formJson(item));
    // }
    // LibraryLocalDataSource localCash;
    // List<dynamic> jsonData2 = jsonDecode(respone);
    List<BookTitleModel> header = (jsonData['headers'] as List)
        .map((e) => BookTitleModel.formJson(e))
        .toList();

    // for (var item in jsonData) {
    //   header.add(BookTitleModel.formJson(item));
    // }
    Library(libraryModel: books, bookTitleModel: header);
// localCash.cachBooks()
    // Map<String, dynamic> data = {"book": books, "header": header};
    // localSource.cachBooks(books);
    return Library(libraryModel: books, bookTitleModel: header);

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
  Future<BookTitleModel> getTitleBooks() async {
    // final response = await client.post(Uri.parse(Constants.schedule));

    // TODO: implement getTitleBooks
    throw UnimplementedError();
  }
}
