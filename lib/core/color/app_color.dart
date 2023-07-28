import 'package:flutter/material.dart';

class AppColors {
  static const kCardColor = Color(0xFF282B30);
  static final bottomHeaderColor = HexColor.fromHex("666A7A");
  static const kBGColor = Color(0xFF343537);
  static const kTextColor = Color.fromARGB(255, 143, 149, 152);
  static const kTextColorlight = Color.fromARGB(255, 56, 179, 115);
  static const kBlackColor = Color.fromARGB(255, 39, 68, 78);
  static const kLightBlackColor = Color(0xFF8F8F8F);
  static const kIconColor = Color(0xFFF48A37);
  static const kProgressIndicator = Color.fromARGB(255, 25, 140, 163);
  static final backgroundPages = HexColor.fromHex("#181a1f");
  static final colorgreen = HexColor.fromHex("3C3E49");
  static final blueColor = HexColor.fromHex("246CFE");

  static final darkRadialBackground = HexColor.fromHex("1D192D");
  final kShadowColor =
      const Color.fromARGB(255, 115, 123, 122).withOpacity(.84);
  static final gray = Color(0xFF737477);
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
