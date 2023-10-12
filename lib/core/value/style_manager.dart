import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:university/core/fonts/app_fonts.dart';

TextStyle _getTextStyleEn(double fontsize, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontsize,
      fontWeight: fontWeight,
      color: color,
      fontFamily: FontConstannts.fontFamily);
}

TextStyle _getAlmraiStyle(double fontsize, FontWeight fontWeight, Color color) {
  return GoogleFonts.almarai(
      color: color, fontSize: fontsize, fontWeight: fontWeight);
}

TextStyle getFontNormal(double fontsize, FontWeight fontWeight, Color color) {
  return _getAlmraiStyle(fontsize, fontWeight, color);
}

TextStyle getRegularStyleEn(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyleEn(fontSize, FontWeightManager.regular, color);
}

TextStyle getMediumStyleEn(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyleEn(fontSize, FontWeightManager.medium, color);
}

TextStyle getBoldStyleEn(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyleEn(fontSize, FontWeightManager.bold, color);
}

TextStyle getLightStyleEn(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyleEn(fontSize, FontWeightManager.laight, color);
}

TextStyle getExtraBoldStyleEn(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyleEn(fontSize, FontWeightManager.extraBold, color);
}

TextStyle getSemiBoldStyleEn(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyleEn(fontSize, FontWeightManager.semiBold, color);
}

TextStyle getBlackStyleEn(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyleEn(fontSize, FontWeightManager.black, color);
}

TextStyle bigHeaderEn({double fontSize = FontSize.s12, required Color color}) {
  return GoogleFonts.lato(
      fontSize: fontSize, color: color, fontWeight: FontWeightManager.bold);
}

TextStyle smallHeaderEn(
    {double fontSize = FontSize.s14, required Color color}) {
  return GoogleFonts.lato(
      fontSize: fontSize, color: color, fontWeight: FontWeightManager.medium);
}
