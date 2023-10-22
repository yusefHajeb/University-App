// ignore_for_file: equal_keys_in_map

import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:university/core/error/execptions.dart';
import 'package:university/features/AllFeatures/data/models/auth_models/singup_model.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/constant/varibal.dart';
import '../../models/auth_models/singin_model.dart';

abstract class SingInOrSingUpRemoteDataSource {
  Future<SingUpModel?> singinStudent(SinginModel singin);
  Future<Unit> singUpStudent(SingUpModel singUp);
}

class SingInOrSingUpRemoteDataSourceImp
    implements SingInOrSingUpRemoteDataSource {
  final http.Client client;

  SingInOrSingUpRemoteDataSourceImp({required this.client});
  @override
  Future<SingUpModel?> singinStudent(SinginModel singin) async {
    const String sinInJson = """[
    {
        "t_id": "47",
        "std_name": "يوسف عبد الملك حاجب",
        "std_password": "1234",
        "std_record": "1234",
        "std_phone": "711111111",
        "batch_id": "12",
        "std_gander": "0",
        "std_image": "assets/images/4.jpg",
        " isOnline": "0",
        "status": "in Company",
        "std_email": "programingdesingers2@gmail.com"
    },
    {
        "t_id": "47",
        "std_name": "عمر جميل",
        "std_password": "12345",
        "std_record": "12345",
        "std_phone": "711111111",
        "batch_id": "12",
        "std_gander": "0",
        "std_image": "assets/images/6.jpg",
        " isOnline": "0",
        "status": "in Company",
        "std_email": "programingdesingers2@gmail.com"
    },
    {
        "t_id": "47",
        "std_name": "عبدالله ",
        "std_password": "20202422",
        "std_record": "0",
        "std_phone": "711111111",
        "batch_id": "12",
        "std_gander": "0",
        "std_image": "assets/images/1.jpg",
        " isOnline": "0",
        "status": "in Company",
        "std_email": "programingdesingers2@gmail.com"
    }
]""";
    final List<dynamic> jsonData = jsonDecode(sinInJson);
    List<SingUpModel> response =
        (jsonData as List).map((e) => SingUpModel.formJson(e)).toList();
    SingUpModel? studentData;
    response.forEach(
      (element) {
        if (element.record == singin.record &&
            element.password == singin.password) {
          studentData = element;
        }
      },
    );
    ;
    print("sing in in Loacl");
    print(singin);
    print("00000000000000000000000000 remote${studentData?.toJson()}");
    // final response = await http.post(
    //   // "http://172.18.48.1:8012/ecommerce/test.php"
    //   Uri.parse("http://172.18.48.1:8012/ecommerce/test.php"),
    //   headers: {
    //     "Content-Type": "application/json",
    //   },
    // );

    // final responseBody = json.decode(response.body);

    // print("$responseBody bbbbbbbbbbbbb");
    // if (responseBody['error'] != null) {
    //   print(
    //       "============================= the error is ${responseBody['error']['message']}");
    // }
    // if (response.statusCode == 200) {
    //   print("============================ remote + response");
    //   final decodedJson = jsonDecode(response.body);

    //   final SinginModel singlModels = SinginModel.fromJson(decodedJson);
    //   // .map((jsonPostModel) => SinginModel.fromJson(jsonPostModel))
    //   // .toList();
    //   print("------------------------------ the data is = $singlModels ");
    //   //     student.password == singin.password &&
    //   //     student.record == singin.record);
    return studentData;
    // final respons = postModels.firstWhere((student) =>
    // } else {
    // print("============================ remote + faild");

    // throw ServerException();
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
