import 'dart:convert';
import 'package:university/features/AllFeatures/data/datasource/library/library_local_data.dart';
import 'package:university/features/AllFeatures/data/models/library_models/library_model.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/network/check_network.dart';

abstract class LibraryRemoteDataSource {
  Future<List<LibraryModel>> getAllBooks();
  Future<BookTitleModel> getTitleBooks();
}

class LibraryRemoteDataSourceImp implements LibraryRemoteDataSource {
  // final http.Client client;
  final http.Client client;
  LibraryRemoteDataSourceImp({required this.client});

  @override
  Future<List<LibraryModel>> getAllBooks() async {
    String respone = """[
     "book" = [{
   "id": "2",
          "category_id": "1",
          "patch_id":"2",
          "subject": "شبكات",
          "img_book": "assets/images/7.jpg",
          "name_book": "Clean advanced",
          "write_book": "Yousef Hajeb",
          "pdfUrl":
              "https://m.media-amazon.com/images/I/41pTqRlersL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg"

  },
  {
          "id": "2",
         "category_id": "3",
          "patch_id": "2",
          "subject": "نطبيقات ذكاء اصطناعي",
          "img_book": "assets/images/5.jpg",
          "name_book": "PHP form beginer to advanced",
          "write_book": "Yousef Hajeb",
          "pdfUrl":
              "https://m.media-amazon.com/images/I/41HvCijjVbL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg",

  },
  {
        "id": "2",
        "category_id":" 3",
        patch_id: 2,
        "subject": "تطبيقات ويب",
        "img_book": "assets/images/4.jpg",
        "name_book": "ابي الجميل",
        "write_book": "Yousef Hajeb",
        "pdfUrl":
            "https://m.media-amazon.com/images/I/41zWWzbiHpL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg",

  },
  {
        "id": "2",
        "category_id": "3",
        "patch_id": "2",
        "subject": "تطبيقات ويب",
        "img_book": "assets/images/4.jpg",
        "name_book": "ابي الجميل",
        "write_book": "Yousef Hajeb",
        "pdfUrl":
            "https://m.media-amazon.com/images/I/41zWWzbiHpL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg",
    
  },
  {
         "id": "2",
        "category_id": "1",
        "patch_id": "2",
        "subject": "حوسبة سحابية",
        "img_book": "assets/images/2.jpg",
        "name_book": "Network form begnersn to advanced",
        "write_book": "Yousef Hajeb",
        "pdfUrl":
            "https://m.media-amazon.com/images/I/51yfA5Mo1hL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg",

  },{
    "id": "2",
        "category_id": "2",
        "patch_id": "2",
        "subject": "برمجة كائنية",
        "img_book": "assets/images/11.jpg",
        "name_book": "Network form begnersn to advanced",
        "write_book": "Yousef Hajeb",
        "pdfUrl":
            "https://m.media-amazon.com/images/I/41pTqRlersL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg",
  },{
            "id": "2",
        "category_id": "2",
        "patch_id": "2",
        "subject": "OOP",
        "img_book": "assets/images/10.jpg",
        "name_book": "Network form begnersn to advanced",
        "write_book": "Yousef Hajeb",
        "pdfUrl":
            "https://m.media-amazon.com/images/I/41pTqRlersL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg",
  }
  ]""";

    List<dynamic> jsonData = jsonDecode(respone);
    List<LibraryModel> books = [];

    for (var item in jsonData) {
      books.add(LibraryModel.formJson(item));
    }
    // localSource.cachBooks(books);
    return books;

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
