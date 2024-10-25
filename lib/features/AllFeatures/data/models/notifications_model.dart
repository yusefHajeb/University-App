import 'package:university/features/AllFeatures/presentation/resources/assets_mananger.dart';

import '../../domain/entites/notification_enitites.dart';

class NotificationModel extends Notifications {
  NotificationModel(
      {String? title,
      String? contact,
      String? instructor,
      String? date,
      bool? note,
      String? iamge})
      : super(
            title: title,
            content: contact,
            newsImage: instructor,
            date: date,
            note: note,
            image: iamge);

  factory NotificationModel.formJson(Map<String, dynamic> data) {
    print("notifications");
    print(data[NotificationModelKeys.content]);
    return NotificationModel(
        title: data[NotificationModelKeys.title]?.toString() ?? "",
        contact: data[NotificationModelKeys.content]?.toString() ?? "",
        date: data[NotificationModelKeys.date]?.toString() ?? "",
        instructor: data[NotificationModelKeys.instructor]?.toString() ?? "",
        note: data[NotificationModelKeys.note] == 0 ? false : true,
        iamge: data[NotificationModelKeys.image] ?? ImageAssets.imageTow);
  }
  Map<String, dynamic> toJson() {
    return {
      NotificationModelKeys.title: title,
      NotificationModelKeys.content: content,
      NotificationModelKeys.date: date,
      NotificationModelKeys.instructor: newsImage,
    };
  }
}

class NotificationModelKeys {
  static String title = "news_header";
  static String instructor = "instructor_name";
  static String date = "news_date";
  static String content = "news_content";
  static String image = "news_image";
  static String note = "notification";
  static String newsImage = "	news_image";
}
