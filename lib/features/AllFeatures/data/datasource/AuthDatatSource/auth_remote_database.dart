import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:university/core/error/execptions.dart';
import 'package:university/features/AllFeatures/data/models/auth_models/singup_model.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/constant/varibal.dart';
import '../../models/auth_models/singin_model.dart';

abstract class SingInOrSingUpRemoteDataSource {
  Future<SinginModel> singinStudent(SinginModel singin);
  Future<Unit> singUpStudent(SingUpModel singUp);
}

class SingInOrSingUpRemoteDataSourceImp
    implements SingInOrSingUpRemoteDataSource {
  final http.Client client;

  SingInOrSingUpRemoteDataSourceImp({required this.client});
  @override
  Future<SinginModel> singinStudent(SinginModel singin) async {
    // final requestBody = {
    //   LoginModelFields.password: singin.password,
    //   LoginModelFields.record: singin.record,
    // };
    print("00000000000000000000000000 remote");

    final response = await http.post(
      // "http://172.18.48.1:8012/ecommerce/test.php"
      Uri.parse("http://172.18.48.1:8012/ecommerce/test.php"),
      headers: {
        "Content-Type": "application/json",
      },
      // body: json.encode(
      //   {
      //     "student": {"password": "12345", "record": "2040"}
      //   },
      // )
    );

    final responseBody = json.decode(response.body);

    print("$responseBody bbbbbbbbbbbbb");
    if (responseBody['error'] != null) {
      print(
          "============================= the error is ${responseBody['error']['message']}");
    }
    if (response.statusCode == 200) {
      print("============================ remote + response");
      final decodedJson = jsonDecode(response.body);

      final SinginModel singlModels = SinginModel.fromJson(decodedJson);
      // .map((jsonPostModel) => SinginModel.fromJson(jsonPostModel))
      // .toList();
      print("------------------------------ the data is = $singlModels ");
      //     student.password == singin.password &&
      //     student.record == singin.record);
      return singlModels;
      // final respons = postModels.firstWhere((student) =>
    } else {
      print("============================ remote + faild");

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
        await client.post(Uri.parse("${Constants.singin}/"), body: requestBody);
    if (response.statusCode == 200) {
      // final decodedJson = jsonDecode(response.body);
      // final SingUpModel postModels = decodedJson
      //     .map((jsonPostModel) => SinginModel.fromJson(jsonPostModel));

      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
