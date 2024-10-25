import 'package:flutter/material.dart';
import 'package:university/chat/domain/entities/single_chat_entity.dart';
import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/presentation/pages/create_group_page.dart';
import 'package:university/chat/presentation/pages/forgot_page.dart';
import 'package:university/chat/presentation/pages/login_page.dart';
import 'package:university/chat/presentation/pages/messages/chats/preview/document_preview_page.dart';
import 'package:university/chat/presentation/pages/messages/chats/preview/image_preview_page.dart';
import 'package:university/chat/presentation/pages/messages/chats/single_chat_page.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/preview_message_content/image_message_preview.dart';
import 'package:university/chat/presentation/pages/messages/chats/widget/preview_message_content/video_message_preview.dart';
import 'package:university/chat/presentation/pages/registration_page.dart';
import 'package:university/core/color/app_color.dart';
import 'package:university/core/value/global.dart';
import 'package:university/features/AllFeatures/presentation/pages/Auth/sing_in_page.dart';
import 'package:university/features/AllFeatures/presentation/pages/Auth/singup_page.dart';
import 'package:university/features/AllFeatures/presentation/pages/application_page.dart';
import 'package:university/features/AllFeatures/presentation/pages/onboarding/onboarding_start.dart';
import 'package:university/features/AllFeatures/presentation/pages/schedule_page.dart';
import '../../../on_generate_route.dart';
import '../../../page_const.dart';

class Routes {
  static const splash = '/';
  static const onBoarding = '/onboarding';
  static const regestetPassword = '/regesterPassword';
  static const singup = '/singup';
  static const singin = '/login';
  static const schedul = '/schedul';
  static const bottomNavigation = '/bottom';
  static const application = '/application-page';
}

class RouteGenerator {
  static Route<dynamic> getRoutes(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.singin:
        {
          print("---------------------------------------router");
          bool getLoged = Global.storgeServece.getLogedUsersFirstSuccess();
          if (getLoged) {
            return MaterialPageRoute(builder: (_) => const ApplicationPage());
          }
          return MaterialPageRoute(builder: (_) => const SingInPage());
        }
      case Routes.singup:
        {
          print("---------------------------------------router2");
          bool getLoged = Global.storgeServece.getLogedUsersFirstSuccess();
          if (getLoged) {
            return MaterialPageRoute(builder: (_) => const ApplicationPage());
          }
          return MaterialPageRoute(builder: (_) => const SingInPage());
        }
      case Routes.schedul:
        return MaterialPageRoute(builder: (_) => SchedulePage());
      case Routes.onBoarding:
        {
          print("---------------------------------------onBoarding");

          bool getDevices = Global.storgeServece.getDeviceFirstOpen();
          if (getDevices) {
            bool logined = Global.storgeServece.getLogedUsersFirstSuccess();
            if (logined) {
              return MaterialPageRoute(builder: (_) => const ApplicationPage());
            } else {
              return MaterialPageRoute(builder: (_) => const SingInPage());
            }
          }
          return MaterialPageRoute(builder: (_) => OnboardingCarousel());
        }

      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => const SingInPage());
      case Routes.application:
        return MaterialPageRoute(builder: (_) => const SingUpPage());
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
        return unDefineRoute();
    }
  }

  static Route<dynamic> unDefineRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              backgroundColor: AppColors.backgroundPages,
              body: Center(
                child: InkWell(
                    onTap: () {
                      Navigator.pop(_);
                    },
                    child: const Text("You are in default Route")),
              ),
            ));
  }
}
