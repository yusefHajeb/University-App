import 'dart:convert';

import 'package:university/features/AllFeatures/data/models/notifications_model.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/constant/varibal.dart';
import '../../../../../core/error/execptions.dart';

abstract class NotificationsRemote {
  Future<List<NotificationModel>> getNotification();
}

class NotificationsRemoteImp implements NotificationsRemote {
  @override
  Future<List<NotificationModel>> getNotification() async {
    print("notifications remote");
    final responce = await http
        .post(Uri.parse(Constants.linkNews), body: {"instructor_id": '${1}'});
    print(responce.body);
    if (responce.statusCode == 200) {
      print("status success notifications");
      var responseData = jsonDecode(responce.body);
      final List decodedJson = responseData["data"];
      print(decodedJson);
      final List<NotificationModel> modelNotification = decodedJson
          .map((jsonNotification) =>
              NotificationModel.formJson(jsonNotification))
          .toList();
      return modelNotification;
    } else {
      throw ServerException();
    }
  }
}
