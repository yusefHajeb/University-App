import 'dart:convert';

import 'package:university/core/constant/varibal.dart';
import 'package:university/features/AllFeatures/data/models/library_models/library_model.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/error/execptions.dart';

abstract class LibraryRemoteDataSource {
  Future<List<LibraryModel>> getAllBooks();
  Future<BookTitleModel> getTitleBooks();
}

class LibraryRemoteDataSourceImp implements LibraryRemoteDataSource {
  final http.Client client;
  LibraryRemoteDataSourceImp({required this.client});

  @override
  Future<List<LibraryModel>> getAllBooks() async {
    final responce = await client.post(Uri.parse(Constants.library), body: {});
    if (responce.statusCode == 200) {
      final List responseData = jsonDecode(responce.body) as List;

      final List<LibraryModel> modelsLibrary = responseData
          .map((jsonLibrary) => LibraryModel.formJson(jsonLibrary))
          .toList();
      return modelsLibrary;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<BookTitleModel> getTitleBooks() async {
    // final response = await client.post(Uri.parse(Constants.schedule));

    // TODO: implement getTitleBooks
    throw UnimplementedError();
  }
}
