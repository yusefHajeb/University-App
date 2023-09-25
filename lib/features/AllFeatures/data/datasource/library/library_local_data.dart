import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:university/core/value/global.dart';
import 'package:university/features/AllFeatures/data/models/library_models/library_model.dart';
import 'package:university/features/AllFeatures/domain/entites/header_books_entites.dart';

import '../../../../../core/error/execptions.dart';

abstract class LibraryLocalDataSource {
  Future<List<LibraryModel>> getCashedBook();
  Future<Unit> cachBooks(List<LibraryModel> data);
}

class LibraryLocalDataSourceImp implements LibraryLocalDataSource {
  //  data = Global.storgeServece.setDataToBox<BookDetaile>("Library");

  @override
  Future<Unit> cachBooks(List<LibraryModel> libraryModel) async {
    final libraryModelToJson = await libraryModel
        .map<Map<String, dynamic>>((schedul) => schedul.toJson())
        .toList();

    // final data = Global.storgeServece.retrieveData<LibraryModel>("Library");
    // if (data != null) {
    // final decodeJsonData = data.map((json)=> LibraryModel.formJson(json)).toList();
// final dacode =  data.map((json) => LibraryModel.(json)).toList();
    final jsonString = Global.storgeServece
        .setString("CACHED_LIBRARY", json.encode(libraryModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<LibraryModel>> getCashedBook() {
    final jsonString = Global.storgeServece.getStringData("CASH_LIBRARY");
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<LibraryModel> jsonToSchedulModel = decodeJsonData
          .map<LibraryModel>((jsonData) => LibraryModel.formJson(jsonData))
          .toList();

      return Future.value(jsonToSchedulModel);
    } else {
      throw EmptyCasheException();
    }
    // TODO: implement getCashedBook
  }
}
