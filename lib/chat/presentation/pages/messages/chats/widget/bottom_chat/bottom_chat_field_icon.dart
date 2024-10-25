// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:unvirstiychat/features/presentation/cubit/bottom_chat/bottom_chat_cubit.dart';
// import 'package:unvirstiychat/features/presentation/cubit/chat/chat_cubit.dart';
// import 'package:unvirstiychat/features/presentation/pages/messages/chats/widget/bottom_chat/bottom_chat_field.dart';
// import 'package:unvirstiychat/features/presentation/pages/messages/chats/widget/bottom_chat/custom_emoji_gif_picker.dart';
// import 'package:unvirstiychat/features/presentation/widgets/theme/style.dart';
// import 'package:unvirstiychat/generated/image_griphy_picker.dart';

// class BottomChatFieldIcon extends StatelessWidget {
//   final String receiverId;
//   final bool isGroupChat;

//   BottomChatFieldIcon(
//       {Key? key, required this.receiverId, required this.isGroupChat})
//       : super(key: key);

//   final TextEditingController messageController =
//       TextEditingController(text: "");
//   FocusNode focusNode = FocusNode();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<BottomChatCubit, BottomChatState>(
//       builder: (context, state) {
//         final cubitRead = context.read<BottomChatCubit>();
//         return WillPopScope(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//                 child: Row(
//                   children: [
//                     BottomChatField(
//                       isGroupChat: isGroupChat,
//                       receiverId: receiverId,
//                       isShowEmoji: cubitRead.isShowEmojiContainer,
//                       focusNode: focusNode,
//                       messageController: messageController,
//                       onTapTextField: () => cubitRead.hideEmojiContainer(),
//                       toggleEmojiKeyboard: () =>
//                           cubitRead.toggleEmojiKeyboard(focusNode),
//                       onTextFieldValueChanged: (value) =>
//                           cubitRead.showSendButton(value),
//                     ),
//                     // if (cubit.isShowSendButton)
//                     if (cubitRead.isShowSendButton)
//                       buildButtonSend(context, cubitRead.isShowSendButton)
//                   ],
//                 ),
//               ),

//               //Offstage is being used to show or hide a CustomEmojiGifPicker widget based on the value of cubitRead.isShowEmojiContainer.
//               // If isShowEmojiContainer is true, the CustomEmojiGifPicker widget will be visible, otherwise it will be hidden.
//               Offstage(
//                 offstage: !cubitRead.isShowEmojiContainer,
//                 child: CustomEmojiGifPicker(
//                   isShowSendButton: cubitRead.isShowSendButton,
//                   messageController: messageController,
//                   onGifButtonTap: () {
//                     selectGif(context);
//                   },
//                 ),
//               )
//             ],
//           ),

//           //onWillPop property is set to a callback function that handles the behavior when the back button is pressed. Inside the callback function,
//           // it first checks if the isShowEmojiContainer property  is true, which means that the emoji container is currently visible. If it is, it calls
//           // the hideEmojiContainer() method to hide the emoji container. Otherwise, it calls Navigator.pop(context) to navigate back to the previous screen.
//           onWillPop: () {
//             if (cubitRead.isShowEmojiContainer) {
//               cubitRead.hideEmojiContainer();
//             } else {
//               Navigator.pop(context);
//             }
//             //the callback function returns a Future.value(false), which means that it prevents the back button press from leaving the current screen.
//             return Future.value(false);
//           },
//         );
//       },
//     );
//   }

//   Widget buildButtonSend(BuildContext context, bool isShowSendButton) {
//     return GestureDetector(
//       onTap: () {
//         // context.read<ChatCubit>().sendTextMessage(
//         //     text: messageController.text.trim(),
//         //     receiverId: receiverId,
//         //     isGroupChat: isGroupChat
//         // );
//         // messageController.clear();
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: kBlueLight2,
//         ),
//         width: 50,
//         height: 50,
//         child: Icon(Icons.send, color: kPrimaryColor),
//       ),
//     );
//   }

//   void selectGif(BuildContext context) async {
//     final gif = await pickGif(context);
//     if (gif != null) {
//       context.read<ChatCubit>().sendGIFMessage(
//           gifUrl: gif.url!, receiverId: receiverId, isGroupChat: isGroupChat);
//     }
//   }
// }
