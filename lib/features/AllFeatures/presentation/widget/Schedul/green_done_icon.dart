import 'package:flutter/material.dart';

import '../../../../../core/color/app_color.dart';

class GreenDoneIcon extends StatelessWidget {
  Color? color;
  IconData icon;
  GreenDoneIcon(this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color != null ? color : AppColors.green),
          child: Icon(
            icon,
            color: AppColors.white,
          )),
    );
  }
}
