import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/features/AllFeatures/presentation/bloc/SchedulBloc/schedul_bloc.dart';
import 'package:university/features/AllFeatures/presentation/pages/onboarding/onboarding_start.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/Utils/lang/app_localization.dart';
import 'enjection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<SchedulBloc>()..add(GetAllScheduleEvent()),
      child:

          // MultiBlocProvider(
          //   providers: BlocProvider(
          //     create: (context) => di.sl<SchedulBloc>()..add(GetAllScheduleEvent()),
          //   ),
          MaterialApp(
        title: 'Flutter Demo',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: OnboardingCarousel(),
        ),
      ),
    );
  }
}
