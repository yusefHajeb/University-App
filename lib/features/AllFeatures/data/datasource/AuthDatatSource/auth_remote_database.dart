import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:university/core/error/execptions.dart';
import 'package:university/features/AllFeatures/data/datasource/data_access.dart';
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
  Future<SingUpModel> singinStudent(SinginModel singin) async {
    print("Outpot ****************" + singin.password);
    // SingUpModel? studentData;
    // final jsonString = Global.storgeServece.getStringData("DATA_DB_USER");
    // List<SingUpModel> students = [];
    // if (jsonString != null) {
    // List decodeJsonData = json.decode(jsonString);
    // students =
    // (decodeJsonData as List).map((e) => SingUpModel.formJson(e)).toList();
    // print("the data user from sharesPrefrence ===== remote");
    // } else {

    // print("Storage user Successfuly ===== remote");
    // uses to store first data
    // List<dynamic> decodeJsonData = json.decode(Constants.apiUser);
    // students =
    // (decodeJsonData as List).map((e) => SingUpModel.formJson(e)).toList();
    // final userModel = await students
    // .map<Map<String, dynamic>>((student) => student.toJson())
    // .toList();
    // Global.storgeServece.setString("DATA_DB_USER", json.encode(userModel));
    // print("Storage user Successfuly ===== remote");
    // }
    // students.forEach(
    // (element) {
    // if (element.record == singin.record &&
    // element.password == singin.password) {
    // studentData = element;
    //     }
    //   },
    // );
    ////============= this true
    // final List<dynamic> jsonData = jsonDecode(Constants.apiUser);
    // List<SingUpModel> response =
    //     (jsonData as List).map((e) => SingUpModel.formJson(e)).toList();
    // SingUpModel? studentData;
    // response.forEach(
    //   (element) {
    //     if (element.record == singin.record &&
    //         element.password == singin.password) {
    //       studentData = element;
    //     }
    //   },
    // );
    // ;
    // print("sing in in Loacl");
    // print(singin);
    // print("00000000000000000000000000 remote${?.toJson()}");
    // try {
    final SingUpModel? singinModel;
    Crud curd = Crud();

    var res = await curd.PostRequset(Constants.singInLink,
        {"record": '${int.parse(singin.record)}', "password": singin.password});

    print("status =====");
    print(res);
    if (res["status"] == "success") {
      print(res["data"]);

      singinModel = SingUpModel.formJson(res["data"]);
      Global.storgeServece.setString(
        Constants.userData,
        json.encode(singinModel),
      );
      return singinModel;
    } else {
      throw ServerException();
    }
    // final response = await http.post(
    //   Uri.parse(Constants.singInLink),
    //   body: {
    //     "record": "${int.parse(singin.record)}",
    //     "password": singin.password
    //   },
    // );
    //   final SingUpModel? singinModel;
    //   print("responseBody");
    //   print(response.statusCode);
    //   print(response.body);
    //   if (response.statusCode == 200) {
    //     print(response.body);
    //     final decodedJson = jsonDecode(response.body);
    //     print(decodedJson);
    //     singinModel = SingUpModel.fromJson(decodedJson);
    //     return Future.value(singinModel);
    //   }
    // } catch (e) {
    //   print("Error catch ${e}");
    // }

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

    // final respons = postModels.firstWhere((student) =>
    // } else {
    // print("============================ remote + faild");

    // throw

    // return singinModel!;
  }

  @override
  Future<Unit> singUpStudent(SingUpModel singUp) async {
    // final requestBody = {
    //   LoginModelFields.password: singUp.password,
    //   LoginModelFields.email: singUp.email,
    //   LoginModelFields.username: singUp.username,
    //   LoginModelFields.record: singUp.record,
    //   LoginModelFields.token: singUp.token
    // };
    final response =
        await client.post(Uri.parse("${Constants.singin}/"), body: {});
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
    print("==== you are in remote $record");
    // final requestBody = {
    //   SingUpModelKeys.name: user.name,
    //   SingUpModelKeys.password: user.password,
    //   SingUpModelKeys.image: user.image,
    //   SingUpModelKeys.phone: user.phone,
    //   SingUpModelKeys.email: user.email,
    // };

    final jsonString = Global.storgeServece.getStringData("DATA_DB_USER");
    List<SingUpModel> students = [];
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      students = decodeJsonData
          .map<SingUpModel>((jsonData) => SingUpModel.formJson(jsonData))
          .toList();

      // final List<dynamic> jsonData = jsonDecode(Constants.apiUser);
      // List<SingUpModel> response =
      //     (jsonData as List).map((e) => SingUpModel.formJson(e)).toList();
      List<SingUpModel> cashed = [];
      students.forEach((element) {
        cashed.add(element);
        if (element.record.toString() == record) {
          SingUpModel dataUser = element.copyWith(
            email: user.email,
            name: user.name,
            phone: user.phone,
            password: user.password,
            // image: user.image,
          );
          Global.storgeServece.setString(
            Constants.userData,
            json.encode(dataUser),
          );
          cashed.add(dataUser);
          // Global.storgeServece.setString(
          //     Constants.userData,
          //     json.encode(element.copyWith(
          //         email: user.email,
          //         name: user.name,
          //         phone: user.phone,
          //         password: user.password,
          //         image: user.image)));
          print("element json");
          print(element.toJson());
        }
      });
      final userModelToJson = await cashed
          .map<Map<String, dynamic>>((user) => user.toJson())
          .toList();
      Global.storgeServece
          .setString("DATA_DB_USER", json.encode(userModelToJson));
    }
// final response = await client.patch(Uri.parse("api"),
//         body: requestBody);
//     if (response.statusCode == 200) {
//       return Future.value(unit);
//     } else {
//       throw ServerException();
//     }
    // TODO: implement updateDataUser

    return Future.value(unit);
  }
}
