import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:university/core/widget/buttons/button_back.dart';
import 'package:university/core/widget/dummy/profile_dummy.dart';

import '../../../features/AllFeatures/presentation/widget/profile_widget/text_autline.dart';
import '../../color/app_color.dart';

class DefaultNav extends StatelessWidget {
  final String title;
  final ProfileDummyType? type;
  const DefaultNav({Key? key, this.type, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      AppBackButton(),
      Text(this.title,
          style: GoogleFonts.lato(fontSize: 20, color: Colors.white)),
      Builder(builder: (context) {
        if (type == ProfileDummyType.icon) {
          return ProfileDummy(
              color: HexColor.fromHex("93F0F0"),
              dummyType: ProfileDummyType.image,
              image: "assets/man-head.png",
              scale: 1.2);
        } else if (type == ProfileDummyType.image) {
          return ProfileDummy(
              color: HexColor.fromHex("9F69F9"),
              dummyType: ProfileDummyType.icon,
              scale: 1.0);
        } else if (type == ProfileDummyType.button) {
          return OutlinedButtonWithText(
            width: 75,
            content: "Edit",
            onPressed: () {},
          );
        } else {
          return Container();
        }
      }),
    ]);
  }
}
