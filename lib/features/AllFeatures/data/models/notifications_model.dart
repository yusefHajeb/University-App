import '../../domain/entites/notification_enitites.dart';

class NotificationModel extends Notifications {
  NotificationModel(
      {String? title, String? contact, String? instructor, String? date})
      : super(
            title: title, contant: contact, instructor: instructor, date: date);

  factory NotificationModel.formJson(Map<String, dynamic> data) {
    return NotificationModel(
      title: data[NotificationModelKeys.title],
      contact: data[NotificationModelKeys.content],
      date: data[NotificationModelKeys.date],
      instructor: data[NotificationModelKeys.instructor],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NotificationModelKeys.title: title,
      NotificationModelKeys.content: contant,
      NotificationModelKeys.date: date,
      NotificationModelKeys.instructor: instructor,
    };
  }
}

class NotificationModelKeys {
  static const String title = "notification_title";
  static const String instructor = "instructor_name";
  static const String date = "date_send";
  static const String content = "	notification_contant";
}
