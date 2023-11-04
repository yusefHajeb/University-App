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
    final responce = await http.get(
      Uri.parse(Constants.notificationsLink),
    );
    if (responce.statusCode == 200) {
      final List responseData = jsonDecode(responce.body) as List;

      final List<NotificationModel> modelNotification = responseData
          .map((jsonNotification) =>
              NotificationModel.formJson(jsonNotification))
          .toList();
      return modelNotification;
    } else {
      throw ServerException();
    }
  }
}
