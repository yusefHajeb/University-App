import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../color/app_color.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        children: [
          Positioned(
              top: 20,
              right: 8,
              child: IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/grid.svg",
                  height: 25.0,
                  color: AppColors.kTextColor,
                ),
                onPressed: () {
                  // scaffolKey.currentState!.openDrawer();
                },
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SvgPicture.asset(
                  "assets/icons/grad_cap.png",
                  height: 70.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const Text(
                  "جامعتي",
                  style: TextStyle(
                    color: AppColors.kTextColor,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const CircleAvatar(
                  radius: 25.0,
                  backgroundImage: AssetImage("assets/images/logo.png"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
