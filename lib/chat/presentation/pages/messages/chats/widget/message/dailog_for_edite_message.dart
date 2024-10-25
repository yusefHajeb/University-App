import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/presentation/cubit/chat/chat_cubit.dart';
import 'package:university/chat/presentation/cubit/group/group_cubit.dart';

class MyShowWidgetToEdite extends StatelessWidget {
  final TextMessageEntity textMessageEntity;
  const MyShowWidgetToEdite({super.key, required this.textMessageEntity});

  @override
  Widget build(BuildContext context) {
    String updatedMsg = textMessageEntity.content!;
    return AlertDialog(
      contentPadding:
          const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      //title
      title: Row(
        children: const [
          Icon(
            Icons.message,
            color: Colors.blue,
            size: 28,
          ),
          Text(' تعديل الرسالة')
        ],
      ),

      //content
      content: TextFormField(
        initialValue: updatedMsg,
        autofocus: true,
        maxLines: null,
        onChanged: (value) => updatedMsg = value,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      ),

      //actions
      actions: [
        //cancel button
        MaterialButton(
            onPressed: () {
              //hide alert dialog
              Navigator.pop(context);
            },
            child: const Text(
              'إلغاء',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            )),

        //update button
        MaterialButton(
            onPressed: () {
              //hide alert dialog
              Navigator.pop(context);
              //print(updatedMsg);
              BlocProvider.of<ChatCubit>(context).updateTextMessage(
                textMessageEntity: TextMessageEntity(
                    time: DateTime.now(),
                    messageId: textMessageEntity.messageId,
                    url_madia: textMessageEntity.url_madia,
                    isSend: false,
                    senderProfile: textMessageEntity.senderProfile,
                    senderId: textMessageEntity.senderId,
                    content: updatedMsg,
                    senderName: textMessageEntity.senderName,
                    channellId: textMessageEntity.channellId,
                    type: textMessageEntity.type),
              );
              BlocProvider.of<GroupCubit>(context).refreshGroup();
            },
            child: const Text(
              'تحديث',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ))
      ],
    );
  }
}
