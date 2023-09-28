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
    // String jsonStr =
    String respone = """[
  {
    "coures": "شبكات",
    "instructor": " د / ندى الحميدي",
    "dept": "IT",
    "level": "2",
    "classroom": "الرازي",
    "time": "10:00 AM",
    "days": "السبت",
    "batch": "3"
  },
    {
    "coures": "تطبيقات ذكاء اصطناعي",
    "instructor": "د/اكرم الصباري",
    "dept": "IT",
    "level": "2",
    "classroom": "ابن الهيثم",
    "time": "10:00 AM",
    "days": "الاحد",
    "batch": "3"
  },
  {
    "coures": "تطبيقات ويب",
    "instructor": "د/ عائض الشباطي",
    "dept": "3",
    "level": "3",
    "classroom": "الرازي",
    "time": "2:00 PM",
    "days": "الاثنين",
    "batch": "3"
  },
  {
    "coures": "حوسبة سحابية",
    "instructor": "د/ وليد الشرفي",
    "dept": "IT",
    "level": "Advanced",
    "classroom": "ابن الرازي",
    "time": "2:00 PM",
    "days": "الثلاثاء",
    "batch": "2"
  },
  {
    "coures": "برمحة كائنية",
    "instructor": "د/ فهد الاغبري",
    "dept": "Physics",
    "level": "2",
    "classroom": "الرازي",
    "time": "2:00 PM",
    "days": "الخميس",
    "batch": "Batch B"
  }

]""";
// """;

    final List<dynamic> jsonData = jsonDecode(respone);
    // List<SchedulModel> schedules = [];
    List<SchedulModel> schedules =
        (jsonData as List).map((e) => SchedulModel.formJson(e)).toList();
    // for (var item in jsonData) {
    //   schedules.add(SchedulModel.formJson(item));
    // }

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
