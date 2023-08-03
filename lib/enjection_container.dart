import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/features/AllFeatures/data/datasource/ScheduleDataSource/schedul_local_data_source.dart';
import 'package:university/features/AllFeatures/data/datasource/ScheduleDataSource/shedul_remote_datasource.dart';
import 'package:university/features/AllFeatures/domain/usecase/ScheduleUsecae/get_all_schedule.dart';
import 'package:university/features/AllFeatures/domain/usecase/auth_singin_singup.dart/singin_usecase.dart';
import 'package:university/features/AllFeatures/domain/usecase/auth_singin_singup.dart/singup_usecase.dart';
import 'package:university/features/AllFeatures/presentation/bloc/Onboarding/onboarding_cubit.dart';
import 'package:university/features/AllFeatures/presentation/bloc/SchedulBloc/schedul_bloc.dart';
import 'package:university/core/network/check_network.dart';
import 'package:http/http.dart' as http;
import 'package:university/features/AllFeatures/presentation/bloc/authentication/authentication_bloc.dart';
import 'features/AllFeatures/data/datasource/AuthDatatSource/auth_remote_database.dart';
import 'features/AllFeatures/data/repositories/auth/singin_singup_repository_imp.dart';
import 'features/AllFeatures/data/repositories/schudul_repository_imp.dart';
import 'features/AllFeatures/domain/repositories/auth_repositories/student_repository.dart';
import 'features/AllFeatures/domain/repositories/schedule_repository.dart';
import 'features/AllFeatures/domain/usecase/ScheduleUsecae/notificatin_schedule_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //bloc ===========================
  sl.registerFactory(() => SchedulBloc(
      schedlulenotificationUsecae: sl(), getAllScheduleUsecase: sl()));
  sl.registerFactory(
      () => AuthenticationBloc(singInUsecase: sl(), singUpUsecase: sl()));
  sl.registerFactory(() => OnboardingCubit(pageController: sl()));
  //USECASE ========================
  sl.registerLazySingleton(() => GetAllScheduleUsecase(rerpository: sl()));
  sl.registerLazySingleton(
      () => GetNotificationScheduleUsecase(scheduleRepository: sl()));

  //auth
  sl.registerFactory(() => SingInUsecase(repository: sl()));
  sl.registerFactory(() => SingUpUsecase(repository: sl()));

  //Repository Imp  ================
  sl.registerLazySingleton<ScheduleRepository>(() => SchedulRepositoryImp(
      localSource: sl(), networkInfo: sl(), remoteSchedul: sl()));

  sl.registerLazySingleton<StudentRepository>(
      () => StudentRepositoryImp(networkInfo: sl(), remoteData: sl()));

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

  sl.registerLazySingleton<ScheduleLocalDataSource>(
    () => ScheduleLocalDataSourceImp(
      sharedPreferences: sl(),
    ),
  );

  // Core ===========================

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));

  //ext
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => PageController());
}
