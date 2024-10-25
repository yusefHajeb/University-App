import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:university/core/value/style_manager.dart';
import 'package:university/core/widget/dummy/image_net.dart';
import 'package:university/features/AllFeatures/data/models/user_data.dart';
import 'package:university/features/AllFeatures/presentation/resources/assets_mananger.dart';

import '../../color/app_color.dart';
import '../../value/app_space.dart';
import 'profile_dummy.dart';

class NotificationCard extends StatelessWidget {
  final bool read;
  final String userName;
  final String date;
  final String mention;
  final bool mentioned;
  final String message;
  final String image;
  final String imageBackground;
  final bool userOnline;
  final String newsImage;
  const NotificationCard(
      {Key? key,
      required this.read,
      required this.userName,
      required this.date,
      required this.mention,
      required this.mentioned,
      required this.userOnline,
      required this.message,
      this.newsImage = "",
      this.image = ImageAssets.profile,
      this.imageBackground = "666A7A"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpaces.verticalSpace10,
          newsImage != ""
              ? Container(
                  // height: 140,
                  width: double.infinity,
                  // decoration: BoxDecorationStyles.testStyle,
                  child: CachedNetworkImage(
                    imageUrl: newsImage.toString(),
                    fit: BoxFit.fill,
                  ),
                )
              : SizedBox(),
          AppSpaces.verticalSpace20,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  (image != ImageAssets.profile && image != "")
                      ? ProfileDummyNet(
                          dummyType: ProfileDummyTypeNet.image,
                          scale: 1.5,
                          image: image,
                          color: HexColor.fromHex(imageBackground))
                      : ProfileDummy(
                          dummyType: ProfileDummyType.image,
                          scale: 1.5,
                          image: ImageAssets.ibbUniversity,
                          color: HexColor.fromHex(imageBackground)),
                  userOnline
                      ? Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                              width: 18,
                              height: 18,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.black),
                              child: Center(
                                  child: Container(
                                      width: 14,
                                      height: 14,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: HexColor.fromHex("94D57B"))))))
                      : SizedBox()
                ],
              ),
              AppSpaces.horizontalSpace20,
              Expanded(
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(userName,
                                style:
                                    GoogleFonts.almarai(color: Colors.white)),
                            Text(date,
                                style: GoogleFonts.lato(
                                    color: read
                                        ? HexColor.fromHex("666A7B")
                                        : HexColor.fromHex("B0FFE1")))
                          ],
                        ),
                        AppSpaces.verticalSpace10,
                        mentioned
                            ? RichText(
                                text: TextSpan(
                                  text: 'مرحبا ',
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                    color: HexColor.fromHex("666A7B"),
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '${userDataModel().name}',
                                        style: getFontNormal(
                                            15,
                                            FontWeight.bold,
                                            HexColor.fromHex("EF9EF1"))),
                                    TextSpan(
                                        text: ', $message',
                                        style: GoogleFonts.lato(
                                          fontSize: 16,
                                          color: HexColor.fromHex("666A7B"),
                                        )),
                                  ],
                                ),
                              )
                            : Wrap(direction: Axis.horizontal, children: [
                                Text('$message',
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      color: HexColor.fromHex("666A7B"),
                                    )),
                              ]),
                      ]),
                ),
              )
            ],
          ),
          // Divider(color: HexColor.fromHex("666A7B"))
        ]);
  }
}
