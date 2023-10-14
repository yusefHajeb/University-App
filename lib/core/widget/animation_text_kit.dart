import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../color/app_color.dart';
import '../value/style_manager.dart';

class CustomTextkit extends StatelessWidget {
  final String txt;

  const CustomTextkit({super.key, required this.txt});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(' $txt ',
              speed: const Duration(milliseconds: 90),
              textStyle: getFontNormal(35, FontWeight.bold, AppColors.white)),
        ],
        isRepeatingAnimation: true,
        repeatForever: true,
        displayFullTextOnTap: true,
        stopPauseOnTap: false,
      ),
    );
  }
}
