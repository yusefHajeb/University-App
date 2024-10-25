import 'package:flutter/material.dart';
import 'package:university/core/value/style_manager.dart';

import '../../../../../core/color/app_color.dart';

class OutlinedButtonWithText extends StatelessWidget {
  final String content;
  final double width;
  final VoidCallback? onPressed;
  OutlinedButtonWithText(
      {Key? key, required this.content, required this.width, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: this.width,
        height: 40,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(HexColor.fromHex("181A1F")),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side:
                            BorderSide(color: AppColors.underLine, width: 2)))),

            // color: HexColor.fromHex("246EFE"), width: 2)))),
            child: Center(
                child: Text(content,
                    style:
                        getFontNormal(13, FontWeight.bold, AppColors.white)))));
  }
}
