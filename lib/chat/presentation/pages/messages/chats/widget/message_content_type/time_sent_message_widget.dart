import 'package:flutter/material.dart';
import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/presentation/widgets/theme/style.dart';

class TimeSentMessageWidget extends StatelessWidget {
  final TextMessageEntity messageData;
  final Color colors;
  final bool isSender;

  const TimeSentMessageWidget({
    super.key,
    required this.messageData,
    required this.colors,
    required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4, bottom: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "messageData.time",
          ),
          const SizedBox(width: 5),
          if (isSender)
            Icon(
              Icons.done_all,
              size: 20,
              color: kPrimaryColor,
            ),
        ],
      ),
    );
  }
}
