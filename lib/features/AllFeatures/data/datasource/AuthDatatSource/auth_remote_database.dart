import 'dart:convert';

import 'package:university/core/error/execptions.dart';
import 'package:university/features/AllFeatures/data/models/schedule_model.dart';
import 'package:http/http.dart' as http;
import 'package:university/features/AllFeatures/domain/entites/auth_entites/singin.dart';

import '../../../../../core/constant/varibal.dart';
import '../../models/auth_models/singin_model.dart';

abstract class SingInOrSingUpRemoteDataSource {
  Future<SinginModel> singinStudent(Singin singin);
  Future<SinginModel> getScheduleNotification();
}

class SingInOrSingUpRemoteDataSourceImp
    implements SingInOrSingUpRemoteDataSource {
  final http.Client client;

  SingInOrSingUpRemoteDataSourceImp({required this.client});
  @override
  Future<SinginModel> singinStudent(Singin singin) async {
    final response = await client.get(
      Uri.parse("${AppLink.singin}"),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      final List decodedJson = jsonDecode(response.body) as List;
      final List<SinginModel> postModels = decodedJson
          .map((jsonPostModel) => SinginModel.fromJson(jsonPostModel))
          .toList();

      final respons = postModels.firstWhere((student) =>
          student.password == singin.password &&
          student.record == singin.record);
      return respons;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SinginModel> getScheduleNotification() async {
    final response = await client.get(
      Uri.parse("${AppLink.singin}"),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body);
      final SinginModel postModels = decodedJson
          .map((jsonPostModel) => SinginModel.fromJson(jsonPostModel));
      return postModels;
    } else {
      throw ServerException();
    }
  }
}
