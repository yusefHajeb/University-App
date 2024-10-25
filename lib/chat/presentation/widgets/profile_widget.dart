import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/features/AllFeatures/presentation/resources/assets_mananger.dart';
import 'package:university/generated/Links.dart';

Widget profileWidget({String? imageUrl, File? image}) {
  print("image value $imageUrl");
  if (image == null) {
    if (imageUrl == null)
      return Image.asset(
        ImageAssets.profile,
        fit: BoxFit.cover,
      );
    else {
      // return Image.network("$linkImageRootImage/${imageUrl}");
      return CachedNetworkImage(
        imageUrl: "${Constants.linkImageRootImage}/${imageUrl}",
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
            height: 50,
            width: 50,
            child: Container(
                margin: EdgeInsets.all(20),
                child: CircularProgressIndicator())),
        errorWidget: (context, url, error) => Image.asset(ImageAssets.profile),
      );
    }
  } else {
    return Image.file(
      image,
      fit: BoxFit.cover,
    );
  }
}
