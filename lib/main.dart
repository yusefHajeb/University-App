import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/color/app_color.dart';
import 'package:university/core/value/global.dart';
import 'package:university/features/AllFeatures/presentation/bloc/SchedulBloc/schedul_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/Utils/lang/app_localization.dart';
import 'app/enjection_container.dart' as di;
import 'features/AllFeatures/presentation/bloc/authentication/authentication_bloc.dart';
import 'features/AllFeatures/presentation/bloc/book_favorite_bloc/books_favorite_bloc.dart';
import 'features/AllFeatures/presentation/bloc/form_bloc/bloc/validate_bloc.dart';
import 'features/AllFeatures/presentation/bloc/form_bloc/form_login_bloc.dart';
import 'features/AllFeatures/presentation/bloc/lading_page/lading_page_bloc.dart';
import 'features/AllFeatures/presentation/bloc/library_bloc/library_bloc.dart';
import 'features/AllFeatures/presentation/bloc/onboarding_bloc/on_boarding_bloc_bloc.dart';
import 'features/AllFeatures/presentation/cubit/localization/local_cubit_cubit.dart';
import 'features/AllFeatures/presentation/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await di.init();
  // Bloc.observer = MyBlocObserver();
  // await ScreenUtil.ensureScreenSize();

  await Global.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
  ));
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
          //..to access methode
          create: (context) => LocaleCubit()..getSavedLanguage(),
        ),
        BlocProvider(
          create: (context) =>
              di.sl<ScheduleBloc>()..add(GetAllScheduleEvent(index: 0)),
        ),
        BlocProvider(
          create: (context) => di.sl<AuthenticationBloc>()..add(AuthGetStart()),
        ),
        BlocProvider(
            create: (context) =>
                di.sl<LibraryBloc>()..add(GetBooksLibraryEvent())),
        BlocProvider(
            create: (context) =>
                di.sl<OnBoardingBlocBloc>()..add(OnBoardingBlocEvent())),
        BlocProvider(create: (context) => di.sl<LadingPageBloc>()),
        BlocProvider(create: (context) => di.sl<FormLoginBloc>()),
        BlocProvider(create: (context) => di.sl<ValidateBloc>()),
        BlocProvider(
            create: (context) =>
                di.sl<DownloadBooksBloc>()..add(StartDownloadEvent()))
      ],
      child:
          BlocBuilder<LocaleCubit, ChangeLocalState>(builder: (context, state) {
        return MaterialApp(
          locale: state.locale,
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

          //return and change local lunguage , supportedLocal that phon support
          localeResolutionCallback: (deviceLocal, supportedLocal) {
            // for (var local in supportedLocal) {
            // if my phone support deviceLocal
            // if (deviceLocal != null &&
            //     deviceLocal.languageCode == local.languageCode) {
            //   return deviceLocal;
            // }
            return Locale('ar');
            // }

            // return supportedLocal
            //     .first; //covert eng when no support lunguage deviceLocal
          },
          title: 'Flutter Demo',
          onGenerateRoute: RouteGenerator.getRoutes,
          initialRoute: Routes.onBoarding,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: AppColors.backgroundAccentColor,
            ),
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
          ),
          // home: const LoginPage(),
        );
      }),
    );
  }
}
