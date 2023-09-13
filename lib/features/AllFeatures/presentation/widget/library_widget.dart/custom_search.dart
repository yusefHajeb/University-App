import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:university/core/Utils/box_decoration.dart';

class CustomInputSerch extends StatelessWidget {
  const CustomInputSerch({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeWidth = ScreenUtil().screenWidth;

    return Expanded(
      child: Container(
        height: sizeWidth / 8,
        width: sizeWidth / 1.22,
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: sizeWidth / 30),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.05),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          // controller: controller,
          validator: (val) => val!.isEmpty ? "Can/'t be empty" : null,
          style: TextStyle(color: Colors.black.withOpacity(.8)),

          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black.withOpacity(.7),
            ),
            border: InputBorder.none,
            hintMaxLines: 1,
            hintText: "",
            hintStyle:
                TextStyle(fontSize: 14, color: Colors.black.withOpacity(.5)),
          ),
        ),
      ),
    );
  }
}
