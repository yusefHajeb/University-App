import 'package:flutter/material.dart';
import 'package:university/core/color/app_color.dart';
import 'package:university/generated/helper/time_extension.dart';

class TagChatTime extends StatelessWidget {
  final DateTime dateTime;

  const TagChatTime({Key? key, required this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        margin: const EdgeInsets.all(5),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.backgroundAccentColor),
        child: Text(
          dateTime.getChatDayTime,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
