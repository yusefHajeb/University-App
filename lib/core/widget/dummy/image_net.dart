import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:university/core/constant/varibal.dart';

enum ProfileDummyTypeNet { icon, image, button }

class ProfileDummyNet extends StatelessWidget {
  final ProfileDummyTypeNet dummyType;
  final double scale;
  final String? image;
  final Color? color;
  final IconData? icon;
  ProfileDummyNet(
      {Key? key,
      required this.dummyType,
      required this.scale,
      required this.color,
      this.icon,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40 * scale,
      height: 40 * scale,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: ClipOval(
        child: this.dummyType == ProfileDummyTypeNet.icon
            ? Icon(Icons.person, color: Colors.white, size: 30 * scale)
            : CachedNetworkImage(
                imageUrl: "${Constants.imageRoute}/$image",
                fit: BoxFit.fill,
              ),
      ),
    );
  }
}
