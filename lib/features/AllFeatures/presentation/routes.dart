import 'package:flutter/material.dart';
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
}

class RouteGenerator {
  static Route<dynamic> getRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.singin:
        {
          bool getLoged = Global.storgeServece.getLogedUsersFirstSuccess();
          if (getLoged) {
            return MaterialPageRoute(builder: (_) => SchedulePage());
          }

          return MaterialPageRoute(builder: (_) => SingInPage());
        }
      case Routes.singup:
        return MaterialPageRoute(builder: (_) => SingUpPage());
      case Routes.schedul:
        return MaterialPageRoute(builder: (_) => SchedulePage());
      case Routes.onBoarding:
        {
          bool getDevices = Global.storgeServece.getDeviceFirstOpen();
          if (getDevices) {
            return MaterialPageRoute(builder: (_) => SingInPage());
          }
          return MaterialPageRoute(builder: (_) => OnboardingCarousel());
        }

      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => const ApplicationPage());

      default:
        return unDefineRoute();
    }
  }

  static Route<dynamic> unDefineRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text("No Rout Found"),
              ),
              body: const Center(
                child: Text("You are in default Route"),
              ),
            ));
  }
}
