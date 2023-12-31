import 'package:flutter/material.dart';

class AppColors {
  static final darkRadialBackground =
      // Color.fromARGB(255, 223, 222, 222);
      HexColor.fromHex("1D192D");
  static final backgroundPages =
      // Color.fromARGB(255, 241, 241, 241);
      HexColor.fromHex("#181a1f");
  static final backgrounfContent =
      //  Color.fromARGB(201, 0, 0, 0);
      HexColor.fromHex("3C3E49");
  static final primaryAccentColor = HexColor.fromHex("246CFD");
  static final underLine = HexColor.fromHex("BEF0B2");
  static final error = HexColor.fromHex("f90606");
  static final bottomHeaderColor = HexColor.fromHex("666A7A");
  static final darkGrey = Color(0xFFa7a7a7);
  static final primaryColor = HexColor.fromHex("246CFE");
  static final greyColor =
      // Colors.black38;
      HexColor.fromHex("8F8F8F");
  static final casheColor = HexColor.fromHex("#1abc9c");
  //============================================== mybe Changes
  static final primaryDarkColor = Color(0x80246CFE);
  static final primaryLightColor = Color(0xCC246CFE);
  static final white = Colors.white;
  // Color.fromARGB(255, 21, 17, 17);
  static const kCardColor = Color(0xFF282B30);
  static const kBGColor = Color(0xFF343537);
  static const backgroundAccentColor =
      // = Color.fromARGB(255, 247, 237, 237);
      Color(0xFF262A34);
//=========================================== //cashed
  static const kTextColor = Color.fromARGB(255, 143, 149, 152);
  static const kBlackColor = Color.fromARGB(255, 39, 68, 78);
  static final lightGrey = Color.fromARGB(255, 143, 149, 152);
  static final green = HexColor.fromHex("78B462");

  static final shadowColor =
      const Color.fromARGB(255, 115, 123, 122).withOpacity(.84);
  static const kProgressIndicator = Color.fromARGB(255, 25, 140, 163);
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}
