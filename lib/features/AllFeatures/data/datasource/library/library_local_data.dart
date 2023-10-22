import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/features/AllFeatures/data/models/library_models/library_model.dart';

import '../../../../../core/error/execptions.dart';

abstract class LibraryLocalDataSource {
  Future<Library> getCashedBook();
  Future<Unit> cachBooks(List<LibraryModel> data);
  Future<Unit> cachHeadersBooks(List<BookTitleModel> data);
  List<LibraryModel> getAllBooksCashed();
}

class LibraryLocalDataSourceImp implements LibraryLocalDataSource {
  //  data = Global.storgeServece.setDataToBox<BookDetaile>("Library");
  final SharedPreferences sharedPreferences;

  LibraryLocalDataSourceImp({required this.sharedPreferences});

  @override
  Future<Unit> cachBooks(List<LibraryModel> libraryModel) async {
    List libraryModelToJson = await libraryModel
        .map<Map<String, dynamic>>((book) => book.toJson())
        .toList();

    // final data = Global.storgeServece.retrieveData<LibraryModel>("Library");
    // if (data != null) {
    //     final decodeJsonData = data.map((json)=> LibraryModel.formJson(json)).toList();
    // final dacode =  data.map((json) => LibraryModel.(json)).toList();
    sharedPreferences.setString(
        Constants.booksChach, json.encode(libraryModelToJson));
    print("cached book sucessfuly ===========");
    return Future.value(unit);
  }

  @override
  Future<Library> getCashedBook() {
    print("Cashed Data from DB");
    final jsonString = sharedPreferences.getString(Constants.booksChach);
    final jsonHeaders = sharedPreferences.getString(Constants.headersChach);

    if (jsonString != null && jsonHeaders != null) {
      List decodeJsonData = json.decode(jsonString);
      List decodeHeaders = json.decode(jsonHeaders);
      var localBook = decodeJsonData
          .map<LibraryModel>((jsonData) => LibraryModel.formJson(jsonData))
          .toList();
      print("localBook");
      print(localBook);
      var localHeader = decodeHeaders
          .map<BookTitleModel>((jsonData) => BookTitleModel.formJson(jsonData))
          .toList();

      return Future.value(
          Library(bookTitleModel: localHeader, libraryModel: localBook));
    } else {
      throw EmptyCasheException();
    }
    // TODO: implement getCashedBook
  }

  @override
  Future<Unit> cachHeadersBooks(List<BookTitleModel> data) async {
    List header = await data
        .map<Map<String, dynamic>>((jsonData) => jsonData.toJson())
        .toList();
    sharedPreferences.setString(Constants.headersChach, json.encode(header));
    print("cached header sucessfuly ===========");
    return Future.value(unit);
  }

  @override
  List<LibraryModel> getAllBooksCashed() {
    final jsonString = sharedPreferences.getString(Constants.booksChach);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<LibraryModel> books =
          decodeJsonData.map((e) => LibraryModel.formJson(e)).toList();

      print("Store Library Model");
      print(books);

      return books;
    }
    List<LibraryModel> lib = [];
    return lib;
  }
}
