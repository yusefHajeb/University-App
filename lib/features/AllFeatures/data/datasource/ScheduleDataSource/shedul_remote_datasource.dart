import 'dart:convert';
import 'package:university/core/error/execptions.dart';
import 'package:university/features/AllFeatures/data/models/schedule_model.dart';
import 'package:http/http.dart' as http;
import 'package:university/features/AllFeatures/data/models/user_data.dart';
import '../../../../../core/constant/varibal.dart';

abstract class SchedulRemoteDataSource {
  Future<List<SchedulModel>> getAllSchedul();
  Future<SchedulModel> getScheduleNotification();
  Future<List<SchedulModel>> getLetchersToday(String date);
}

// const String baseUrl = "https://jsonplaceholder.typicode.com";

class SchedulRemoteDataSourceImp implements SchedulRemoteDataSource {
  final http.Client client;

  SchedulRemoteDataSourceImp({required this.client});
  @override
  Future<List<SchedulModel>> getAllSchedul() async {
    print("---------- remote");
    final response = await http
        .post(Uri.parse(Constants.scheduleLink), body: {"batch_id": '12'});
    print("response");
    print(response.body);
    if (response.statusCode == 200) {
      var responsbody = jsonDecode(response.body);

      print(response.body);
      final List decodedJson = responsbody["data"];
      print(decodedJson);

      final List<SchedulModel> scheduleModel = decodedJson
          .map((jsonPostModel) => SchedulModel.formJson(jsonPostModel))
          .toList();

      return scheduleModel;
    }
    throw ServerException();
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

// "${now.year}-${now.month}-${now.day}"
  @override
  Future<List<SchedulModel>> getLetchersToday(String date) async {
    print("---------- getLetchers");
    print("---------- getLetchers");

    final now = DateTime.now();
    String? today;
    if (int.parse(date) < 10) {
      today = "0${date}";
    } else {
      today = date;
    }

    print("---------- getLetchers : ${now.year}-${now.month}-${today}");

    try {
      final response = await http.post(Uri.parse(Constants.letchersLinks),
          body: {
            "batch_id": '${12}',
            "date_lectuer": "${now.year}-${now.month}-${today}"
          });
      print("response");
      print(response.body);
      if (response.statusCode == 200) {
        var responsbody = jsonDecode(response.body);
        print("responsbody['status']");
        print(responsbody['status']);

        // print(response.body);
        final List decodedJson = responsbody["data"];
        // print(decodedJson);
        final List<SchedulModel> scheduleModel = decodedJson
            .map((jsonPostModel) => SchedulModel.formJson(jsonPostModel))
            .toList();
        return scheduleModel;
      }
    } catch (e) {
      print(" ================  $e");
      // throw ServerException();
    }
    throw ServerException();
  }
}
