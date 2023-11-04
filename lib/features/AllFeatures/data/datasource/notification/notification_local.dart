import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/core/error/execptions.dart';
import 'package:university/features/AllFeatures/data/models/notifications_model.dart';

import '../../../../../core/constant/varibal.dart';

abstract class NotificationsLocal {
  Future<List<NotificationModel>> getNotifications();
  Future<Unit> cachedNotifications(List<NotificationModel> data);
}

class NotificationsLocalImp implements NotificationsLocal {
  final SharedPreferences sharedPreferences;

  NotificationsLocalImp({required this.sharedPreferences});

  @override
  Future<Unit> cachedNotifications(List<NotificationModel> data) {
    final note =
        data.map<Map<String, dynamic>>((notes) => notes.toJson()).toList();
    sharedPreferences.setString(
        Constants.cachedNotifications, json.encode(note));
    return Future.value(unit);
  }

  @override
  Future<List<NotificationModel>> getNotifications() {
    final jsonData = sharedPreferences.getString(Constants.cachedNotifications);
    if (jsonData != null) {
      List decodeData = jsonDecode(jsonData);
      List<NotificationModel> jsonToNote = decodeData
          .map<NotificationModel>((data) => NotificationModel.formJson(data))
          .toList();
      return Future.value(jsonToNote);
    } else {
      throw EmptyCasheException();
    }
  }
}
