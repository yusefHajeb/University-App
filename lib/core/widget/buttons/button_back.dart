import 'package:flutter/material.dart';
import 'package:university/core/widget/buttons/custom_button_with_icon.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: RoundedBorderWithIcon(icon: Icons.arrow_back),
    );
  }
}
