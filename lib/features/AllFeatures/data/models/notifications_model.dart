import 'package:flutter/material.dart';

import '../../domain/entites/notification_enitites.dart';

class NotificationModel extends Notificatons {
  NotificationModel(
      {String? title, String? contant, String? instructor, String? date})
      : super(
            title: title, contant: contant, instructor: instructor, date: date);

  factory NotificationModel.formJson(Map<String, dynamic> data) {
    return NotificationModel(
      title: data[NotificationModelKeys.title],
      contant: data[NotificationModelKeys.content],
      date: data[NotificationModelKeys.date],
      instructor: data[NotificationModelKeys.inshtructor],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NotificationModelKeys.title: title,
      NotificationModelKeys.content: contant,
      NotificationModelKeys.date: date,
      NotificationModelKeys.inshtructor: instructor,
    };
  }
}

class NotificationModelKeys {
  static const String title = "notification_title";
  static const String inshtructor = "instructor_name";
  static const String date = "date_send";
  static const String content = "	notification_contant";
}
