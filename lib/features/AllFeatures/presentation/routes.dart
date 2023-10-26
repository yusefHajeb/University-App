import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:university/core/value/global.dart';
import 'package:university/features/AllFeatures/presentation/pages/Auth/sing_in_page.dart';
import 'package:university/features/AllFeatures/presentation/pages/Auth/singup_page.dart';
import 'package:university/features/AllFeatures/presentation/pages/application_page.dart';
import 'package:university/features/AllFeatures/presentation/pages/onboarding/onboarding_start.dart';
import 'package:university/features/AllFeatures/presentation/pages/schedule_page.dart';

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
    switch (settings.name) {
      case Routes.singin:
        {
          print("---------------------------------------router");
          bool getLoged = Global.storgeServece.getLogedUsersFirstSuccess();
          if (getLoged) {
            return MaterialPageRoute(builder: (_) => ApplicationPage());
          }
          return MaterialPageRoute(builder: (_) => SingInPage());
        }
      case Routes.singup:
        {
          print("---------------------------------------router2");
          bool getLoged = Global.storgeServece.getLogedUsersFirstSuccess();
          if (getLoged) {
            return MaterialPageRoute(builder: (_) => ApplicationPage());
          }
          return MaterialPageRoute(builder: (_) => SingInPage());
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
              return MaterialPageRoute(builder: (_) => ApplicationPage());
            } else {
              return MaterialPageRoute(builder: (_) => SingInPage());
            }
          }
          return MaterialPageRoute(builder: (_) => OnboardingCarousel());
        }

      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => const SingInPage());
      case Routes.application:
        return MaterialPageRoute(builder: (_) => const SingUpPage());

      default:
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
        // });
        return unDefineRoute();
    }
  }

  static Route<dynamic> unDefineRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text("No Rout Found"),
              ),
              body: Center(
                child: InkWell(
                    onTap: () {
                      Navigator.pop(_);
                    },
                    child: Text("You are in default Route")),
              ),
            ));
  }
}
