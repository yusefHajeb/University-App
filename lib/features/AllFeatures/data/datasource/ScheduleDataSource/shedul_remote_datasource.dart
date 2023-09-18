import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:university/core/error/execptions.dart';
import 'package:university/features/AllFeatures/data/models/schedule_model.dart';
import 'package:http/http.dart' as http;
import 'package:university/features/AllFeatures/domain/entites/schedule.dart';

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
    // String jsonStr =
    String respone = """[
  {
    "coures": "Math",
    "instructor": "John Doe",
    "dept": "Mathematics",
    "level": "Intermediate",
    "classroom": "Room 101",
    "time": "10:00 AM",
    "days": "Monday - Friday",
    "batch": "Batch A"
  },
  {
    "coures": "Science",
    "instructor": "Jane Smith",
    "dept": "Physics",
    "level": "Advanced",
    "classroom": "Room 202",
    "time": "2:00 PM",
    "days": "Monday - Thursday",
    "batch": "Batch B"
  },
  {
    "coures": "Science",
    "instructor": "Jane Smith",
    "dept": "Physics",
    "level": "Advanced",
    "classroom": "Room 202",
    "time": "2:00 PM",
    "days": "Monday - Thursday",
    "batch": "Batch B"
  },
  {
    "coures": "Science",
    "instructor": "Jane Smith",
    "dept": "Physics",
    "level": "Advanced",
    "classroom": "Room 202",
    "time": "2:00 PM",
    "days": "Monday - Thursday",
    "batch": "Batch B"
  }

]""";
// """;

    List<dynamic> jsonData = jsonDecode(respone);
    List<SchedulModel> schedules = [];

    for (var item in jsonData) {
      schedules.add(SchedulModel.formJson(item));
    }

    // final response = await client.get(
    //   // Uri.parse("http://10.0.2.2:8012/university/schedule/schedule.php"),
    //   Uri.parse(Constants.baseUrl),
    // );

    // if (response.statusCode == 200) {
    //   print(response.body);
    //   final List decodedJson = jsonDecode(response.body) as List;
    //   final List<SchedulModel> postModels = decodedJson
    //       .map((jsonPostModel) => SchedulModel.formJson(jsonPostModel))
    //       .toList();
    // print("$postModels ==== schedul ");
    return schedules;
    // } else {
    //   print("error =====in remote sechudal in no states200");
    //   throw ServerException();
    // }
  }

  @override
  Future<SchedulModel> getScheduleNotification() async {
    final response = await client.get(
      Uri.parse("${Constants.schedule}"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      print('SUCESS ============= remote schedule');
      final decodedJson = jsonDecode(response.body);
      final SchedulModel schedulModel =
          decodedJson.map((jsonModel) => SchedulModel.formJson(jsonModel));
      return schedulModel;
    } else {
      throw ServerException();
    }
  }
}
