import 'package:flutter/material.dart';
import 'package:university/features/AllFeatures/presentation/resources/assets_mananger.dart';

import '../../../../../core/color/app_color.dart';

class PageContainer extends StatelessWidget {
  const PageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        child: PageView.builder(
          itemBuilder: (context, index) {
            return _buildPageItem(2);
          },
        ));
  }
}

Widget _buildPageItem(int index) {
  return Container(
      height: 220,
      margin: EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(300),
          color: index.isEven
              ? AppColors.backgroundPages
              : AppColors.backgrounfContent,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                ImageAssets.imageOne,
              ))));
}
