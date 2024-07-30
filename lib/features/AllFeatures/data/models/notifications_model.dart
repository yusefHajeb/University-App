import '../../domain/entites/notification_enitites.dart';

class NotificationModel extends Notifications {
  NotificationModel(
      {String? title, String? contact, String? instructor, String? date})
      : super(
            title: title, contant: contact, instructor: instructor, date: date);

  factory NotificationModel.formJson(Map<String, dynamic> data) {
    print("notifications");
    print(data[NotificationModelKeys.content]);
    return NotificationModel(
      title: data[NotificationModelKeys.title]?.toString() ?? "",
      contact: data["notification_contant"]?.toString() ?? "",
      date: data[NotificationModelKeys.date]?.toString() ?? "",
      instructor: data[NotificationModelKeys.instructor]?.toString() ?? "",
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
  static String title = "notification_title";
  static String instructor = "instructor_name";
  static String date = "date_send";
  static String content = "	notification_contant";
}
