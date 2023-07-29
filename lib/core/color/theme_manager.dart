import 'package:flutter/material.dart';
import 'package:university/core/color/app_color.dart';
import 'package:university/core/fonts/app_fonts.dart';
import 'package:university/core/value/margin_manager.dart';
import '../value/style_manager.dart';

ThemeData getAppTheme() {
  return ThemeData(
      primaryColor: AppColors.primaryColor,
      primaryColorDark: AppColors.primaryDarkColor,
      primaryColorLight: AppColors.primaryLightColor,
      disabledColor: AppColors.greyColor,
      splashColor: AppColors.primaryLightColor,
      cardTheme: CardTheme(
        color: AppColors.white,
        shadowColor: AppColors.shadowColor,
        elevation: AppSize.s4,
      ),
      //AppBar theme
      appBarTheme: AppBarTheme(
        color: AppColors.primaryColor,
        centerTitle: true,
        titleTextStyle:
            getRegularStyleEn(color: AppColors.white, fontSize: AppSize.s16),
        elevation: AppSize.s4,
      ),
      //button Theme
      buttonTheme: ButtonThemeData(
        shape: StadiumBorder(),
        disabledColor: AppColors.greyColor,
        buttonColor: AppColors.primaryColor,
        splashColor: AppColors.primaryLightColor,
      ),
      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyleEn(
                color: AppColors.white, fontSize: FontSize.s18),
            primary: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s12),
            )),
      ),
      textTheme: TextTheme(
          headline1: getSemiBoldStyleEn(
              color: AppColors.darkGrey, fontSize: AppSize.s16),
          subtitle1: getMediumStyleEn(
              color: AppColors.lightGrey, fontSize: AppSize.s14),
          caption: getRegularStyleEn(color: AppColors.greyColor),
          bodyText1: getRegularStyleEn(color: AppColors.lightGrey)),
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.all(AppPadding.p8),
          hintStyle: getRegularStyleEn(
              color: AppColors.greyColor, fontSize: AppSize.s14),
          //label style
          labelStyle: getMediumStyleEn(
              color: AppColors.greyColor, fontSize: AppSize.s14),
          //error Style
          errorStyle: getRegularStyleEn(
              color: AppColors.greyColor, fontSize: AppSize.s14),
          //enabledBorder
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: AppSize.s1_0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s4))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.darkGrey,
                width: AppSize.s1_0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s4))),
          //error boder
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.error,
                width: AppSize.s1_0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s4))),
          //fouced error
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: AppSize.s1_0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s4))))

      //focused
      );
}
