import 'package:flutter/material.dart';
import 'package:university/chat/domain/entities/single_chat_entity.dart';
import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/presentation/pages/create_group_page.dart';
import 'package:university/chat/presentation/pages/messages/chats/preview/document_preview_page.dart';
import 'package:university/chat/presentation/pages/messages/chats/preview/image_preview_page.dart';
import 'package:university/chat/presentation/pages/messages/chats/single_chat_page.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/preview_message_content/image_message_preview.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/preview_message_content/video_message_preview.dart';
import 'package:university/page_const.dart';

import 'chat/presentation/pages/forgot_page.dart';
import 'chat/presentation/pages/login_page.dart';
import 'chat/presentation/pages/registration_page.dart';
// import 'features/presentation/pages/forgot_page.dart';
// import 'features/presentation/pages/login_page.dart';
// import 'features/presentation/pages/registration_page.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case PageConst.createGroupPage:
        {
          if (args is String) {
            return materialBuilder(
              widget: CreateGroupPage(
                uid: args,
              ),
            );
          } else {
            return materialBuilder(
              widget: const ErrorPage(),
            );
          }
        }
      case PageConst.singleChatPage:
        {
          if (args is SingleChatEntity) {
            return materialBuilder(
              widget: SingleChatPage(
                singleChatEntity: args,
              ),
            );
          } else {
            return materialBuilder(
              widget: const ErrorPage(),
            );
          }
        }
      case PageConst.loginPage:
        {
          return materialBuilder(
            widget: LoginPage(),
          );
        }
      case PageConst.forgotPage:
        {
          return materialBuilder(
            widget: ForgetPassPage(),
          );
        }
      case PageConst.loginPage:
        {
          return materialBuilder(
            widget: LoginPage(),
          );
        }
      case PageConst.registrationPage:
        {
          return materialBuilder(
            widget: RegistrationPage(),
          );
        }
      case PageConst.imagemessagepreview:
        {
          if (args is TextMessageEntity) {
            return materialBuilder(
              widget: ImageMessagePreview(
                messageData: args,
              ),
            );
          } else {
            return materialBuilder(
              widget: const ErrorPage(),
            );
          }
        }
      case PageConst.routeNameimagepreview:
        {
          final arguments = settings.arguments as ImagePreviewPage;
          return MaterialPageRoute(
              builder: (context) => ImagePreviewPage(
                    imageFilePath: arguments.imageFilePath,
                    receiverId: arguments.receiverId,
                    userData: arguments.userData,
                    singleChatEntity: arguments.singleChatEntity,
                  ));
        }
      case PageConst.routeNamedocumentpreview:
        {
          final arguments = settings.arguments as DocumentPreviewPage;
          return MaterialPageRoute(
              builder: (context) => DocumentPreviewPage(
                    DocumentFilePath: arguments.DocumentFilePath,
                    receiverId: arguments.receiverId,
                    userData: arguments.userData,
                    singleChatEntity: arguments.singleChatEntity,
                  ));
        }

      case PageConst.vediomessagepreview:
        {
          if (args is TextMessageEntity) {
            return materialBuilder(
              widget: VideoMessagePreview(
                messageData: args,
              ),
            );
          } else {
            return materialBuilder(
              widget: const ErrorPage(),
            );
          }
        }
      case PageConst.phoneRegistrationPage:
      default:
        return materialBuilder(
          widget: const ErrorPage(),
        );
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("error"),
      ),
      body: const Center(
        child: Text("error"),
      ),
    );
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
