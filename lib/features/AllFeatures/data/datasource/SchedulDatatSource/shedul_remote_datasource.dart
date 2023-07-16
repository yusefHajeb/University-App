import 'dart:convert';

import 'package:university/core/error/execptions.dart';
import 'package:university/features/AllFeatures/data/models/schedule_model.dart';
import 'package:http/http.dart' as http;

abstract class SchedulRemoteDataSource {
  Future<List<SchedulModel>> getAllSchedul();
}

const String baseUrl = "https://jsonplaceholder.typicode.com";

class SchedulRemoteDataSourceImp implements SchedulRemoteDataSource {
  final http.Client client;

  SchedulRemoteDataSourceImp({required this.client});
  @override
  Future<List<SchedulModel>> getAllSchedul() async {
    final response = await client.get(
      Uri.parse("$baseUrl/posts/"),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      final List decodedJson = jsonDecode(response.body) as List;
      final List<SchedulModel> postModels = decodedJson
          .map((jsonPostModel) => SchedulModel.formJson(jsonPostModel))
          .toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }
}
