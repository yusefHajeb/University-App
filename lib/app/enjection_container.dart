import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/features/AllFeatures/data/datasource/ScheduleDataSource/schedul_local_data_source.dart';
import 'package:university/features/AllFeatures/data/datasource/ScheduleDataSource/shedul_remote_datasource.dart';
import 'package:university/features/AllFeatures/data/datasource/library/library_local_data.dart';
import 'package:university/features/AllFeatures/data/datasource/library/library_remote_data.dart';
import 'package:university/features/AllFeatures/data/datasource/notification/notification_local.dart';
import 'package:university/features/AllFeatures/data/datasource/notification/ontification_remote.dart';
import 'package:university/features/AllFeatures/data/repositories/library_repository/library_repository_imp.dart';
import 'package:university/features/AllFeatures/data/repositories/notefications_repository/notifications_imp.dart';
import 'package:university/features/AllFeatures/domain/repositories/library_repositories/library_repository.dart';
import 'package:university/features/AllFeatures/domain/repositories/notification/notification_repository.dart';
import 'package:university/features/AllFeatures/domain/usecase/ScheduleUsecae/get_all_schedule.dart';
import 'package:university/features/AllFeatures/domain/usecase/ScheduleUsecae/get_tody_letchers.dart';
import 'package:university/features/AllFeatures/domain/usecase/auth_singin_singup.dart/singin_usecase.dart';
import 'package:university/features/AllFeatures/domain/usecase/auth_singin_singup.dart/singup_usecase.dart';
import 'package:university/features/AllFeatures/domain/usecase/auth_singin_singup.dart/update_data_user.dart';
import 'package:university/features/AllFeatures/domain/usecase/library_usecase/books_usecase.dart';
import 'package:university/features/AllFeatures/domain/usecase/library_usecase/curse_usecase.dart';
import 'package:university/features/AllFeatures/domain/usecase/library_usecase/library_usecase.dart';
import 'package:university/features/AllFeatures/presentation/bloc/SchedulBloc/schedul_bloc.dart';
import 'package:university/core/network/check_network.dart';
import 'package:http/http.dart' as http;
import 'package:university/features/AllFeatures/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:university/features/AllFeatures/presentation/bloc/lading_page/lading_page_bloc.dart';
import 'package:university/features/AllFeatures/presentation/bloc/notifications/notefications_bloc.dart';
import 'package:university/features/AllFeatures/presentation/bloc/search_books/search_books_bloc.dart';
import '../features/AllFeatures/data/datasource/AuthDatatSource/auth_remote_database.dart';
import '../features/AllFeatures/data/repositories/auth/singin_singup_repository_imp.dart';
import '../features/AllFeatures/data/repositories/schudul_repository_imp.dart';
import '../features/AllFeatures/domain/repositories/auth_repositories/student_repository.dart';
import '../features/AllFeatures/domain/repositories/schedule_repository.dart';
import '../features/AllFeatures/domain/usecase/ScheduleUsecae/notificatin_schedule_usecase.dart';
import '../features/AllFeatures/domain/usecase/notification/note_usecase.dart';
import '../features/AllFeatures/presentation/bloc/book_favorite_bloc/books_favorite_bloc.dart';
import '../features/AllFeatures/presentation/bloc/form_bloc/bloc/validate_bloc.dart';
import '../features/AllFeatures/presentation/bloc/form_bloc/form_login_bloc.dart';
import '../features/AllFeatures/presentation/bloc/library_bloc/library_bloc.dart';
import '../features/AllFeatures/presentation/bloc/onboarding_bloc/on_boarding_bloc_bloc.dart';
import '../features/AllFeatures/presentation/helpers/bloc_observer.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //bloc ===========================

  sl.registerFactory(() => DownloadBooksBloc());
  sl.registerFactory(() => LadingPageBloc());
  sl.registerFactory(() =>
      ScheduleBloc(getAllScheduleUsecase: sl(), getLetchersUsecase: sl()));
  sl.registerFactory(() => OnBoardingBlocBloc());
  sl.registerFactory(() => SearchBooksBloc(sl()));
  sl.registerFactory(() => FormLoginBloc());
  sl.registerFactory(() => AuthenticationBloc(
      updateUserData: sl(), singInUsecase: sl(), singUpUsecase: sl()));
  sl.registerFactory(() => LibraryBloc(
      getAllBooksUsecase: sl(), getBookUsecase: sl(), getCoursesUsecase: sl()));
  // sl.registerFactory(() => LibraryBloc());

  sl.registerFactory(() => ValidateBloc());
  sl.registerFactory(() => Bloc.observer = MyBlocObserver());
  sl.registerFactory(() => NotificationsBloc(getAllNotifications: sl()));
  //USECASE ========================
  sl.registerLazySingleton(() => GetAllScheduleUsecase(rerpository: sl()));
  sl.registerLazySingleton(() => GetLetchersUsecase(rerpository: sl()));

  sl.registerLazySingleton(
      () => GetNotificationScheduleUsecase(scheduleRepository: sl()));
  //auth  =======
  sl.registerLazySingleton(() => UpdateDataUserUsecase(repository: sl()));
  sl.registerLazySingleton(() => SingInUsecase(repository: sl()));
  sl.registerLazySingleton(() => SingUpUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetAllBooksUsecase(rerpository: sl()));
  sl.registerLazySingleton(() => GetBookUsecase(rerpository: sl()));
  sl.registerLazySingleton(() => GetCoursesUsecase(rerpository: sl()));
  sl.registerLazySingleton(() => GetAllNotifications(repository: sl()));
  //Repository Imp  ================

  sl.registerLazySingleton<ScheduleRepository>(() => SchedulRepositoryImp(
      localSource: sl(), networkInfo: sl(), remoteSchedul: sl()));
  sl.registerLazySingleton<StudentRepository>(
      () => StudentRepositoryImp(networkInfo: sl(), remoteData: sl()));

  sl.registerLazySingleton<LibraryRepository>(() => LibraryRepositoryImp(
      localSource: sl(), remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<NotificationRepository>(() =>
      NotificationRepositoryImp(remote: sl(), local: sl(), networkInfo: sl()));
  //Database =======================
  sl.registerLazySingleton<SchedulRemoteDataSource>(
    () => SchedulRemoteDataSourceImp(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<SingInOrSingUpRemoteDataSource>(
    () => SingInOrSingUpRemoteDataSourceImp(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<LibraryRemoteDataSource>(
    () => LibraryRemoteDataSourceImp(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<ScheduleLocalDataSource>(
    () => ScheduleLocalDataSourceImp(
      sharedPreferences: sl(),
    ),
  );

  // sl.registerLazySingleton<LibraryLocalDataSource>(
  //     () => LibraryLocalDataSourceImp(sharedPreferences: sl()));

  sl.registerLazySingleton<LibraryLocalDataSource>(
      () => LibraryLocalDataSourceImp(
            sharedPreferences: sl(),
          ));

  sl.registerLazySingleton<NotificationsRemote>(() => NotificationsRemoteImp());
  sl.registerLazySingleton<NotificationsLocal>(
      () => NotificationsLocalImp(sharedPreferences: sl()));

  // Core ===========================

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));
  sl.registerLazySingleton<NetworkInfoImp>(() => NetworkInfoImp(sl()));

  //ext
  final sharedPreferences = await SharedPreferences.getInstance();

  // final  hive   = await Hive.
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => PageController());
  sl.registerLazySingleton(() => WidgetsFlutterBinding.ensureInitialized());
  sl.registerLazySingleton<TextEditingController>(
      () => TextEditingController());
  sl.registerLazySingleton(() => BuildContext);

  sl.registerLazySingleton<GlobalKey<FormState>>(() => GlobalKey<FormState>());
}
