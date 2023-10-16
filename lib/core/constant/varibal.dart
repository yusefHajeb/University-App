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
  // static const baseUrl = "https://q97wg.wiremockapi.cloud";

  // static const singin = "$baseUrl/auth/singup.php";
  static const singin = "$baseUrl/login/student";

  static const schedule = "$baseUrl/test.php";
  static const library = "$baseUrl/university/library";
}
