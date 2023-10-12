import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/core/value/global.dart';
import 'package:university/features/AllFeatures/data/models/library_models/library_model.dart';

import '../../../../../core/error/execptions.dart';

abstract class LibraryLocalDataSource {
  Future<Library> getCashedBook();
  Future<Unit> cachBooks(List<LibraryModel> data);
  Future<Unit> cachHeadersBooks(List<BookTitleModel> data);
}

class LibraryLocalDataSourceImp implements LibraryLocalDataSource {
  //  data = Global.storgeServece.setDataToBox<BookDetaile>("Library");

  @override
  Future<Unit> cachBooks(List<LibraryModel> libraryModel) {
    // List libraryModelToJson = libraryModel
    //     .map<Map<String, dynamic>>((book) => book.toJson())
    //     .toList();

    // final data = Global.storgeServece.retrieveData<LibraryModel>("Library");
    // if (data != null) {
    // final decodeJsonData = data.map((json)=> LibraryModel.formJson(json)).toList();
// final dacode =  data.map((json) => LibraryModel.(json)).toList();
    // final jsonString = Global.storgeServece
    //     .setString(Constants.booksChach, json.encode(libraryModelToJson));
    print("cached book sucessfuly ===========");
    return Future.value(unit);
  }

  @override
  Future<Library> getCashedBook() {
    final jsonString = Global.storgeServece.getStringData(Constants.booksChach);
    final jsonHeaders =
        Global.storgeServece.getStringData(Constants.headersChach);

    if (jsonString != null && jsonHeaders != null) {
      List decodeJsonData = json.decode(jsonString);
      List decodeHeaders = json.decode(jsonHeaders);
      var localBook = decodeJsonData
          .map<LibraryModel>((jsonData) => LibraryModel.formJson(jsonData))
          .toList();
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
  Future<Unit> cachHeadersBooks(List<BookTitleModel> data) {
    List header = data
        .map<Map<String, dynamic>>((jsonData) => jsonData.toJson())
        .toList();
    Global.storgeServece.setString(Constants.headersChach, json.encode(header));
    print("cached header sucessfuly ===========");
    return Future.value(unit);
  }
}
