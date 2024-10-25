import 'package:flutter/cupertino.dart';

import '../color/app_color.dart';

Size appSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

const kCalendarDay = TextStyle(
  color: AppColors.kTextColor,
  fontSize: 16.0,
);

List<Color> progressCardGradientList = [
  //grenn
  HexColor.fromHex("87EFB5"),
  //blue
  HexColor.fromHex("8ABFFC"),
  //pink
  HexColor.fromHex("EEB2E8"),
];

class Constants {
  static const String empty = "";
  static const STORGE_DEVICE_OPEN_FIRST_TIME = "stroge_device_open_time";
  static const STORGE_USER_LOGED_FIRST = 'storge_loged_user';
  static const baseUrl = "http://10.0.0.2/university";
  static const booksChach = "CASH_BOOKS";
  static const headersChach = "CASH_HEADERS_BOOKS";
  static const savedBooks = "DOWNLOAD_BOOKS";
  static const cachedSchedule = "CACHED_SCHEDUL";
  static const cachedLetchers = "CACHED_LETCHERS";
  static const userData = "STUDEN_DATA";
  static const cachedNotifications = "CACHED_NOTIFICATIONS";
  // static const baseUrl = "https://q97wg.wiremockapi.cloud";
  // static const singin = "$baseUrl/auth/singup.php";
  static const singin = "$baseUrl/login/student";
  static const schedule = "$baseUrl/test.php";
  static const library = "$baseUrl/university/library";
//this is Linls
  // static const String serverIp = "http://192.168.1.10";
  static const String serverIp = "http://10.0.2.2";
// const String serverIp = "http://10.0.2.2";
  static const String linkPuplicNodeServerName = "${serverIp}:3000";
  static const String singInLink = "$linkPuplicNodeServerName/signIn";
  static const String test = "$linkPuplicNodeServerName/getsignIn";
  static const String imageRoute = "$serverIp/UniversitySystem/StudentsImage/";
  static const String scheduleLink =
      "$linkPuplicNodeServerName/getAllLectuerForAppStudent";
  static const String updageStudentData =
      "$linkPuplicNodeServerName/uploadImageStudent";
  static const String letchersLinks =
      "$linkPuplicNodeServerName/getLectuerForAppstudentEquleDay";
  static const String linkgetAllGoups =
      "$linkPuplicNodeServerName/group/getGroups.php";
//  static const String linkImageRootImageChat = "$ServerIp/UniversitySystem/ChatMadia";

  static const String libraryLink =
      "$linkPuplicNodeServerName/getcouresForAppstudent";
  static const String notificationsLink =
      "$linkPuplicNodeServerName/GetAllNotifictionToInstructor";

  static const String imageBooksRoute =
      "$serverIp/UniversitySystem/StudentsImage/";
  static const String imageNews = "$serverIp/UniversitySystem/imageNews/";

  static const String imageInstractor =
      "$serverIp/UniversitySystem/instructorProfile/";
  static const String pdfRoute = "$serverIp/UniversitySystem/StudentsImage/";

  static const String linkgetMessageGoups =
      "$linkPuplicNodeServerName/group/getMessage.php";
  static const String linkHome = "$linkPuplicNodeServerName/image.php";
  static const String linkNews = "$linkPuplicNodeServerName/GetNews";
  static const String linkImageRootImageChat =
      "$serverIp/UniversitySystem/ChatMadia/";
  static const String linksendMessageGoups =
      "$linkPuplicNodeServerName/group/messageGroup/add_message.php";
  static const String linklastMessageGoups =
      "$serverIp/group/messageGroup/last_message_group.php";

  static const String link_update_state =
      "$linkPuplicNodeServerName/update_on_stateLecture.php";
  static const String link_select_notific =
      "$linkPuplicNodeServerName/Notification/GetNotific.php";
  static const String linkCountNewMessageGoups =
      "$linkPuplicNodeServerName/group/messageGroup/count_message_new.php";

  static const String linkImageRootImage =
      "$serverIp/UniversitySystem/StudentsImage";

  static String apiUser = """[
    {
        "t_id": "47",
        "std_name": "يوسف عبد الملك حاجب",
        "std_password": "1234",
        "std_record": "1234",
        "std_phone": "711111111",
        "batch_id": "12",
        "std_gander": "0",
        "std_image": "assets/images/4.jpg",
        " isOnline": "0",
        "status": "in Company",
        "std_email": "programingdesingers2@gmail.com"
    },
    {
        "t_id": "47",
        "std_name": "عمر جميل",
        "std_password": "12345",
        "std_record": "12345",
        "std_phone": "711111111",
        "batch_id": "12",
        "std_gander": "0",
        "std_image": "assets/images/6.jpg",
        " isOnline": "0",
        "status": "in Company",
        "std_email": "programingdesingers2@gmail.com"
    },
    {
        "t_id": "47",
        "std_name": "عبدالله ",
        "std_password": "20202422",
        "std_record": "0",
        "std_phone": "711111111",
        "batch_id": "12",
        "std_gander": "0",
        "std_image": "assets/images/1.jpg",
        " isOnline": "0",
        "status": "in Company",
        "std_email": "programingdesingers2@gmail.com"
    }
]""";
}
