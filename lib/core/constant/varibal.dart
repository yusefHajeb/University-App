import 'package:flutter/cupertino.dart';

import '../color/app_color.dart';

Size sizeHeight(BuildContext context) {
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

class AppLink {
  static const baseUrl = "http://localhost:8012/university";
  static const singin = "$baseUrl/auth/singup.php";
  static const schedule = "$baseUrl/auth/singup.php";
}
