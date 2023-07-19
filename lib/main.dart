import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:university/features/AllFeatures/presentation/bloc/SchedulBloc/schedul_bloc.dart';
import 'package:university/features/AllFeatures/presentation/pages/onboarding/onboarding_start.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/Utils/lang/app_localization.dart';
import 'enjection_container.dart' as di;
import 'features/AllFeatures/presentation/bloc/authentication/authentication_bloc.dart';
import 'features/AllFeatures/presentation/pages/Auth/login_page.dart';
import 'features/AllFeatures/presentation/pages/Auth/sing_in_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<SchedulBloc>()..add(GetAllScheduleEvent()),
        ),
        BlocProvider(
          create: (context) => di.sl<AuthenticationBloc>()..add(AuthGetStart()),
        ),
      ],
      child: ScreenUtilInit(builder: (context, child) {
        return MaterialApp(
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
          home: SingInPage(),
        );
      }),
    );
  }
}
