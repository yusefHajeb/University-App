import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/color/app_color.dart';

class SubmitFormBtn extends StatelessWidget {
  final VoidCallback onPressed;

  final String btnName;
  const SubmitFormBtn(
      {Key? key, required this.onPressed, required this.btnName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    final sizeWidth = ScreenUtil().screenWidth;

    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        height: sizeWidth / 8,
        width: sizeWidth / 4,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.backgrounfContent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          btnName,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
