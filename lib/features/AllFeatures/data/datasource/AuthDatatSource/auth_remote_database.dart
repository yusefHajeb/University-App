import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:university/core/error/execptions.dart';
import 'package:university/features/AllFeatures/data/models/auth_models/singup_model.dart';
import 'package:university/features/AllFeatures/data/models/schedule_model.dart';
import 'package:http/http.dart' as http;
import 'package:university/features/AllFeatures/domain/entites/auth_entites/singin.dart';
import 'package:university/features/AllFeatures/domain/entites/auth_entites/singup.dart';

import '../../../../../core/constant/varibal.dart';
import '../../models/auth_models/singin_model.dart';

abstract class SingInOrSingUpRemoteDataSource {
  Future<Unit> singinStudent(SinginModel singin);
  Future<Unit> singUpStudent(SingUpModel singUp);
}

class SingInOrSingUpRemoteDataSourceImp
    implements SingInOrSingUpRemoteDataSource {
  final http.Client client;

  SingInOrSingUpRemoteDataSourceImp({required this.client});
  @override
  Future<Unit> singinStudent(SinginModel singin) async {
    final requestBody = {
      LoginModelFields.password: singin.password,
      LoginModelFields.record: singin.record,
    };

    final response =
        await client.post(Uri.parse("${AppLink.singin}/"), body: requestBody);

    if (response.statusCode == 200) {
      // final List decodedJson = jsonDecode(response.body) as List;
      // final List<SinginModel> postModels = decodedJson
      //     .map((jsonPostModel) => SinginModel.fromJson(jsonPostModel))
      //     .toList();

      // final respons = postModels.firstWhere((student) =>
      //     student.password == singin.password &&
      //     student.record == singin.record);
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> singUpStudent(SingUpModel singUp) async {
    final requestBody = {
      LoginModelFields.password: singUp.password,
      LoginModelFields.email: singUp.email,
      LoginModelFields.username: singUp.username,
      LoginModelFields.record: singUp.record,
      LoginModelFields.token: singUp.token
    };
    final response =
        await client.post(Uri.parse("${AppLink.singin}/"), body: requestBody);
    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body);
      // final SingUpModel postModels = decodedJson
      //     .map((jsonPostModel) => SinginModel.fromJson(jsonPostModel));

      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
