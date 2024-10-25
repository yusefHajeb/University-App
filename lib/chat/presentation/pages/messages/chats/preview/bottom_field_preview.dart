import 'package:flutter/material.dart';
import 'package:university/chat/presentation/widgets/theme/style.dart';

class BottomFieldPreview extends StatelessWidget {
  final VoidCallback onSendButtonTaped;
  final TextEditingController captionController;

  const BottomFieldPreview(
      {Key? key,
      required this.onSendButtonTaped,
      required this.captionController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              // onChanged: onTextFieldValueChanged,
              controller: captionController,
              // focusNode: focusNode,
              cursorColor: kGreyColor,
              maxLines: null,
              textAlignVertical: TextAlignVertical.center,
              textInputAction: TextInputAction.newline,
              style: TextStyle(
                fontSize: 20,
                color: kBackgroundColor,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: 'إضافة شرح...',
                hintStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.white54,
                  fontWeight: FontWeight.normal,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ),
        SizedBox(width: 2),
        GestureDetector(
            onTap: onSendButtonTaped,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: greenColor,
              child: Icon(
                Icons.send,
                color: kPrimaryColor,
              ),
            )),
      ]),
    );
  }
}
