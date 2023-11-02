import 'dart:convert';
import 'package:university/core/error/execptions.dart';
import 'package:university/features/AllFeatures/data/models/schedule_model.dart';
import 'package:http/http.dart' as http;
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
    // String jsonStr =
//     String respone = """
//   [{
//     "t_id": "9" ,
//     "coures_name": "شبكات",
//     "instructor_name": " د / ندى الحميدي",
//     "dept_name": "IT",
//     "level_name": "2",
//     "classroom_name": "الرازي",
//     "time_name": "10:00 AM",
//     "day_id": "السبت",
//     "batch_name": "3",
//     "state_lectuer": "مؤكدة",
//     " note": "لاجديد"
//   },
// {
//     "t_id": "5" ,
//     "coures_name": "تطبيقات ذكاء اصطناعي",
//     "instructor_name": "د/اكرم الصباري",
//     "dept_name": "IT",
//     "level_name": "2",
//     "classroom_name": "ابن الهيثم",
//     "time_name": "10:00 AM",
//     "day_id": "السبت",
//     "batch_name": "3",
//     "state_lectuer": "قيد الإنتظار",
//     " note": "لاجديد"
//   },
//     {
//     "t_id": "5" ,
//     "coures_name": "تطبيقات ويب",
//     "instructor _name": "د/ عائض الشباطي",
//     "dept_name": "IT",
//     "level_name": "2",
//     "classroom_name": "الرازي",
//     "time_name": "10:00 AM",
//     "day_id": "الإثنين",
//     "batch_name": "3",
//     "state_lectuer": "ملغي",
//     " note": "لاجديد"
//   },
//   {
//     "t_id": "5" ,
//     "coures_name": "تطبيقات ويب",
//     "instructor_name": "د/ عائض الشباطي",
//     "dept_name": "IT",
//     "level_name": "2",
//     "classroom_name": "الرازي",
//     "time_name": "10:00 AM",
//     "day_id": "الخميس",
//     "batch_name": "3",
//     "state_lectuer": "قيد الإنتظار",
//     " note": "لاجديد"
//   },
//   {
//     "t_id": "5" ,
//     "coures_name": "برمجة ",
//     "instructor _name": "د/ عمر الشريفي",
//     "dept_name": "IT",
//     "level_name": "2",
//     "classroom_name": "الرازي",
//     "time_name": "10:00 AM",
//     "day_id": "الإثنين",
//     "batch_name": "3",
//     "state_lectuer": "قيد الإنتظار",
//     " note": "لاجديد"
//   }

// ]
// """;
//  ----------------------------------------------""";

    // final List<dynamic> jsonData = jsonDecode(respone);
    // List<SchedulModel> schedules = [];
    //----------------------------------------------
    // List<SchedulModel> schedules =
    //     (jsonData as List).map((e) => SchedulModel.formJson(e)).toList();
    //-----------------------------------------
    // for (var item in jsonData) {
    //   schedules.add(SchedulModel.formJson(item));
    // }

    print("---------- remote");
    final response = await http
        .post(Uri.parse(Constants.scheduleLink), body: {"batch_id": '${12}'});
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
      // } else {
      //   print("error =====in remote sechudal in no states200");
      //   throw ServerException();
      // }
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
    final now = DateTime.now();
    String? today;
    if (int.parse(date) < 10) {
      today = "0${date}";
    } else {
      today = date;
    }
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
