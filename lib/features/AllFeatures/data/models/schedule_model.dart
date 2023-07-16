import 'package:flutter/foundation.dart';

import '../../domain/entites/schedule.dart';

class SchedulModel extends Schedule {
  SchedulModel(
      {required String subject,
      required String type,
      required String teacherName,
      required DateTime time})
      : super(
          subject: subject,
          type: type,
          teacherName: teacherName,
          time: time,
        );

  factory SchedulModel.formJson(Map<String, dynamic> json) {
    return SchedulModel(
        subject: json['subject'],
        type: json['type'],
        teacherName: json['teacherName'],
        time: json['time']);
  }

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'type': type,
      'teacherName': teacherName,
      'time': time
    };
  }
}
