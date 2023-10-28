import 'package:flutter/material.dart';

import '../../../../../core/color/app_color.dart';

class Skelton extends StatelessWidget {
  const Skelton({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);
  final double? width, height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: AppColors.backgrounfContent,
          borderRadius: const BorderRadius.all(Radius.circular(16))),
    );
  }
}
