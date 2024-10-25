import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/presentation/widgets/theme/style.dart';

class AppBarMessagePreview extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarMessagePreview({
    super.key,
    required this.messageData,
  });

  final TextMessageEntity messageData;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      leading: BackButton(color: Colors.white),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            messageData.senderName!,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 3),
          Text(
              '${DateFormat('dd-MM-yyyy   hh:mm a').format(messageData.time!)}',
              style: TextStyle(fontSize: 12, color: Colors.white))
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.star_border),
          color: Colors.white,
        ),
        IconButton(
          onPressed: () {},
          color: Colors.white,
          icon: const Icon(CupertinoIcons.arrow_turn_up_right),
        ),
        //CustomPopUpMenuButton(buttons: _buttons(context), colors: kBlackColor)
      ],
    );
  }

  // List<PopUpMenuItemModel> _buttons(context) => [
  //       PopUpMenuItemModel(
  //         name: "Edit",
  //         onTap: () {},
  //       ),
  //       PopUpMenuItemModel(
  //         name: "All media",
  //         onTap: () {},
  //       ),
  //       PopUpMenuItemModel(
  //         name: "Show in message",
  //         onTap: () {},
  //       ),
  //       PopUpMenuItemModel(
  //         name: "Share",
  //         onTap: () {},
  //       ),
  //       PopUpMenuItemModel(
  //         name: "Save",
  //         onTap: () {},
  //       ),
  //       PopUpMenuItemModel(
  //         name: "See in gallery",
  //         onTap: () {},
  //       ),
  //     ];

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
