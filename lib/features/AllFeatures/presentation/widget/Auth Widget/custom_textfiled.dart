import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFilde extends StatelessWidget {
  final IconData icon;
  final TextEditingController controller;
  final String hintText;
  final bool? isPassword;
  final bool? isEmail;
  const CustomTextFilde(
      {super.key,
      required this.icon,
      required this.hintText,
      this.isPassword,
      this.isEmail,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final sizeWidth = ScreenUtil().screenWidth;
    return Container(
      height: sizeWidth / 8,
      width: sizeWidth / 1.22,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: sizeWidth / 30),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        validator: (val) => val!.isEmpty ? "Can/'t be empty" : null,
        style: TextStyle(color: Colors.black.withOpacity(.8)),
        obscureText: isPassword ?? false,
        keyboardType: (isEmail ?? false)
            ? TextInputType.emailAddress
            : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.black.withOpacity(.7),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle:
              TextStyle(fontSize: 14, color: Colors.black.withOpacity(.5)),
        ),
      ),
    );
  }
}
