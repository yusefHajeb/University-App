import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:math' as math;

import '../../../../../core/Utils/lang/app_localization.dart';

class SliderCaptionedImage extends StatelessWidget {
  final int index;
  final String caption;
  final String imageUrl;
  const SliderCaptionedImage(
      {Key? key,
      required this.index,
      required this.caption,
      required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
          top: 0,
          child: AppLocalizations.of(context)!.local == Locale('ar')
              ? Transform(
                  transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                  alignment: Alignment.center,
                  child: Image(
                      image: AssetImage(this.imageUrl),
                      fit: BoxFit.fill,
                      height: 450),
                )
              : Image(
                  image: AssetImage(this.imageUrl),
                  fit: BoxFit.contain,
                  height: 450)),
      Positioned(
          bottom: 20,
          left: AppLocalizations.of(context)!.local == Locale('ar') ? 0 : 20,
          right: AppLocalizations.of(context)!.local == Locale('ar') ? 20 : 0,
          child: Text(caption,
              style: GoogleFonts.raleway(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Color.fromARGB(255, 255, 251, 252)))),
      index == 0
          ? Positioned(
              bottom: 70,
              right: 50,
              child: Transform.scale(
                scale: 0.3,
                child:
                    Transform.rotate(angle: -math.pi / 2, child: Container()),
              ))
          : SizedBox()
    ]);
  }
}
