import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/core/error/failure.dart';
import 'package:university/features/AllFeatures/data/models/library_models/library_model.dart';

import '../../../../../core/error/execptions.dart';

abstract class LibraryLocalDataSource {
  Future<Library> getCashedBook();
  Future<Unit> cachBooks(List<BookModel> data);
  Future<Unit> cachHeadersBooks(List<BookTitleModel> data);
  List<BookModel> getAllBooksCashed();
  List<BookTitleModel> getCourse();
}

class LibraryLocalDataSourceImp implements LibraryLocalDataSource {
  final SharedPreferences sharedPreferences;

  LibraryLocalDataSourceImp({required this.sharedPreferences});

  @override
  Future<Unit> cachBooks(List<BookModel> libraryModel) async {
    List libraryModelToJson = await libraryModel
        .map<Map<String, dynamic>>((book) => book.toJson())
        .toList();

    // final data = Global.storgeServece.retrieveData<LibraryModel>("Library");
    // if (data != null) {
    //     final decodeJsonData = data.map((json)=> LibraryModel.formJson(json)).toList();
    // final dacode =  data.map((json) => LibraryModel.(json)).toList();
    sharedPreferences.setString(
        Constants.booksChach, json.encode(libraryModelToJson));
    return Future.value(unit);
  }

  @override
  Future<Library> getCashedBook() {
    final jsonString = sharedPreferences.getString(Constants.booksChach);
    final jsonHeaders = sharedPreferences.getString(Constants.headersChach);

    if (jsonString != null && jsonHeaders != null) {
      List decodeJsonData = json.decode(jsonString);
      List decodeHeaders = json.decode(jsonHeaders);
      var localBook = decodeJsonData
          .map<BookModel>((jsonData) => BookModel.formJson(jsonData))
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
    List header = data
        .map<Map<String, dynamic>>((jsonData) => jsonData.toJson())
        .toList();
    sharedPreferences.setString(Constants.headersChach, json.encode(header));
    print("cached header sucessfuly ===========");
    return Future.value(unit);
  }

  @override
  List<BookModel> getAllBooksCashed() {
    final jsonString = sharedPreferences.getString(Constants.booksChach);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<BookModel> books =
          decodeJsonData.map((e) => BookModel.formJson(e)).toList();

      return books;
    }
    List<BookModel> lib = [];
    return lib;
  }

  @override
  List<BookTitleModel> getCourse() {
    final jsonHeaders = sharedPreferences.getString(Constants.headersChach);

    if (jsonHeaders != null) {
      List decodeHeaders = json.decode(jsonHeaders);

      var localHeader = decodeHeaders
          .map<BookTitleModel>((jsonData) => BookTitleModel.formJson(jsonData))
          .toList();
      return localHeader;
    }
    throw ServerFailure();
  }
}
