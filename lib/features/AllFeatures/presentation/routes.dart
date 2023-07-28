import 'package:flutter/material.dart';
import 'package:university/features/AllFeatures/presentation/pages/Auth/sing_in_page.dart';
import 'package:university/features/AllFeatures/presentation/pages/Auth/singup_page.dart';
import 'package:university/features/AllFeatures/presentation/pages/schedule_page.dart';

class Routes {
  static const splash = '/';
  static const onBoarding = '/onboarding';
  static const regestetPassword = '/regesterPassword';
  static const singup = '/singup';
  static const singin = '/login';
  static const schedul = '/schedul';
}

class RouteGenerator {
  static Route<dynamic> getRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.singin:
        return MaterialPageRoute(builder: (_) => SingInPage());
      case Routes.singup:
        return MaterialPageRoute(builder: (_) => SingUpPage());
      case Routes.singin:
        return MaterialPageRoute(builder: (_) => SchedulePage());

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
