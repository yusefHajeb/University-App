import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:university/core/error/execptions.dart';
import 'package:university/features/AllFeatures/data/models/auth_models/singup_model.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/constant/varibal.dart';
import '../../../../../core/value/global.dart';
import '../../models/auth_models/singin_model.dart';

abstract class SingInOrSingUpRemoteDataSource {
  Future<SingUpModel?> singinStudent(SinginModel singin);
  Future<Unit> singUpStudent(SingUpModel singUp);
  Future<Unit> updateDataUser(SingUpModel user);
}

class SingInOrSingUpRemoteDataSourceImp
    implements SingInOrSingUpRemoteDataSource {
  final http.Client client;

  SingInOrSingUpRemoteDataSourceImp({required this.client});
  @override
  Future<SingUpModel?> singinStudent(SinginModel singin) async {
    final List<dynamic> jsonData = jsonDecode(Constants.apiUser);
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

  @override
  Future<Unit> updateDataUser(SingUpModel user) async {
    final record = user.record;

    // final requestBody = {
    //   SingUpModelKeys.name: user.name,
    //   SingUpModelKeys.password: user.password,
    //   SingUpModelKeys.image: user.image,
    //   SingUpModelKeys.phone: user.phone,
    //   SingUpModelKeys.email: user.email,
    // };

    final List<dynamic> jsonData = jsonDecode(Constants.apiUser);
    List<SingUpModel> request =
        (jsonData as List).map((e) => SingUpModel.formJson(e)).toList();

    request.forEach((element) {
      if (element.record == record) {
        element.copyWith(
            email: user.email,
            name: user.name,
            phone: user.phone,
            password: user.password,
            image: user.image);
        Global.storgeServece
            .setString(Constants.userData, json.encode(element.toJson()));
      }
    });
    final userModelToJson = await request
        .map<Map<String, dynamic>>((user) => user.toJson())
        .toList();
    Constants.apiUser = json.encode(userModelToJson);
// final response = await client.patch(Uri.parse("api"),
//         body: requestBody);
//     if (response.statusCode == 200) {
//       return Future.value(unit);
//     } else {
//       throw ServerException();
//     }
    // TODO: implement updateDataUser
    throw UnimplementedError();
  }
}
