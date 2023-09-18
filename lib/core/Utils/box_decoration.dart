import 'package:flutter/material.dart';
import 'package:university/core/Utils/schape.dart';

import '../color/app_color.dart';

class BoxDecorationStyles {
  static final BoxDecoration fadingGlory = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          HexColor.fromHex("#EBF5EE"),
          Color.fromRGBO(218, 223, 255, 1),
          HexColor.fromHex("#EBF5EE"),
          HexColor.fromHex("#EBF5EE")
        ]),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    //border: Border.all(color: Colors.red, width: 5)
  );

  static final BoxDecoration backgroundBlack = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          // AppColors.backgroundPages,
          Color.fromARGB(255, 5, 8, 9),
          AppColors.primaryAccentColor

          // Color.fromRGBO(218, 223, 255, 1),
          // HexColor.fromHex("#EBF5EE"),
          // HexColor.fromHex("#EBF5EE")
        ]),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    //border: Border.all(color: Colors.red, width: 5)
  );

  static final BoxDecoration fadingInnerDecor = BoxDecoration(
      color: HexColor.fromHex("#eeeeee"),
      borderRadius: BorderRadius.circular(20));

  static final BoxDecoration cardSchedule = BoxDecoration(
      color: HexColor.fromHex("#eeeeee"),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3))
      ]);
}
