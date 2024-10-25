import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/preview_message_content/app_bar_message_preview.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/generated/Links.dart';

class ImageMessagePreview extends StatelessWidget {
  static const routeName = "image-message-preview";
  final TextMessageEntity messageData;

  const ImageMessagePreview({Key? key, required this.messageData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBarMessagePreview(messageData: messageData),
        body: Center(
          child: CachedNetworkImage(
              imageUrl:
                  "${Constants.linkImageRootImageChat}/${messageData.url_madia!}",
              width: double.infinity,
              fit: BoxFit.contain,
              placeholder: (context, url) => const CircularProgressIndicator()),
        ));
  }
}
