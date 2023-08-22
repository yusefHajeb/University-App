import 'dart:convert';

import 'package:university/core/error/execptions.dart';
import 'package:university/features/AllFeatures/data/models/schedule_model.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/constant/varibal.dart';

abstract class SchedulRemoteDataSource {
  Future<List<SchedulModel>> getAllSchedul();
  Future<SchedulModel> getScheduleNotification();
}

// const String baseUrl = "https://jsonplaceholder.typicode.com";

class SchedulRemoteDataSourceImp implements SchedulRemoteDataSource {
  final http.Client client;

  SchedulRemoteDataSourceImp({required this.client});
  @override
  Future<List<SchedulModel>> getAllSchedul() async {
    final response = await client.get(
      // Uri.parse("http://10.0.2.2:8012/university/schedule/schedule.php"),
      Uri.parse("http://172.25.224.1:8012/university/schedule/schedule.php"),
    );

    if (response.statusCode == 200) {
      final List decodedJson = jsonDecode(response.body) as List;
      final List<SchedulModel> postModels = decodedJson
          .map((jsonPostModel) => SchedulModel.formJson(jsonPostModel))
          .toList();
      print("$postModels ==== schedul ");
      return postModels;
    } else {
      print("error ===== ");
      throw ServerException();
    }
  }

  @override
  Future<SchedulModel> getScheduleNotification() async {
    final response = await client.get(
      Uri.parse("${AppLink.schedule}"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      print('SUCESS ============= remote schedule');
      final decodedJson = jsonDecode(response.body);
      final SchedulModel postModels = decodedJson
          .map((jsonPostModel) => SchedulModel.formJson(jsonPostModel));
      return postModels;
    } else {
      throw ServerException();
    }
  }
}
