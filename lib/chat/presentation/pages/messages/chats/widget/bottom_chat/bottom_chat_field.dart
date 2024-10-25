// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ngandika_app/data/models/message_reply_model.dart';
// import 'package:ngandika_app/presentation/bloc/message/chat/chat_state.dart';
// import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/bottom_chat/custom_attachment_pop_up.dart';
// import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/message/message_reply_preview.dart';
// import 'package:ngandika_app/utils/styles/style.dart';

// import '../../../../../../bloc/message/chat/chat_cubit.dart';

// class BottomChatField extends StatelessWidget {
//   final VoidCallback toggleEmojiKeyboard;
//   final VoidCallback onTapTextField;
//   final bool isShowEmoji;
//   final TextEditingController messageController;
//   final Function(String) onTextFieldValueChanged;
//   final FocusNode focusNode;
//   final String receiverId;

//   final bool isGroupChat;

//   const BottomChatField({
//     Key? key,
//     required this.onTapTextField,
//     required this.messageController,
//     required this.focusNode,
//     required this.onTextFieldValueChanged,
//     required this.isShowEmoji,
//     required this.toggleEmojiKeyboard,
//     required this.receiverId,
//     required this.isGroupChat}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width - 85,
//       margin: const EdgeInsets.only(right: 10),
//       decoration: BoxDecoration(
//         color: kPrimaryColor,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(width: 1, color: kGreyColor)
//       ),
//       child: Column(
//         children: [
//           //this blocBuilder to show message replay preview
//           BlocBuilder<ChatCubit, ChatState>(
//             builder: (context, state) {
//               MessageReplyModel? messageReply = context.watch<ChatCubit>().messageReplay;
//               if (messageReply == null) {
//                 return const SizedBox();
//               }
//               return MessageReplyPreview(messageReply: messageReply);
//             },
//           ),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               IconButton(
//                   onPressed: toggleEmojiKeyboard,
//                   color: kGreyColor,
//                   iconSize: 25,
//                   icon: Icon(isShowEmoji
//                       ? Icons.keyboard_alt_outlined
//                       : Icons.emoji_emotions)),
//               Flexible(
//                 //The ConstrainedBox widget is used to set constraints on the size of its child widget, which is a Scrollbar widget.
//                 child: ConstrainedBox(
//                   constraints: const BoxConstraints(
//                     minWidth: double.infinity,
//                     maxWidth: double.infinity,
//                     minHeight: 25,
//                     maxHeight: 135,
//                   ),

//                   //The ConstrainedBox widget is used to set constraints on the size of its child widget, which is a Scrollbar widget.
//                   child: Scrollbar(
//                     child: TextField(
//                       onTap: onTapTextField,
//                       onChanged: onTextFieldValueChanged,
//                       controller: messageController,
//                       focusNode: focusNode,
//                       cursorColor: kGreyColor,
//                       maxLines: null,
//                       textAlignVertical: TextAlignVertical.center,
//                       textInputAction: TextInputAction.newline,
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: kBlackColor,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       decoration: InputDecoration(
//                         hintText: 'Message',
//                         hintStyle: TextStyle(
//                           fontSize: 20,
//                           color: kGreyColor,
//                           fontWeight: FontWeight.normal,
//                         ),
//                         border: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               //this to attach file, image or audio
//               CustomAttachmentPopUp(receiverId: receiverId, isGroupChat: isGroupChat)
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
