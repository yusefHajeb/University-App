import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/features/AllFeatures/data/datasource/ScheduleDataSource/schedul_local_data_source.dart';
import 'package:university/features/AllFeatures/data/datasource/ScheduleDataSource/shedul_remote_datasource.dart';
import 'package:university/features/AllFeatures/data/repositories/schudul_repository_imp.dart';
import 'package:university/features/AllFeatures/domain/usecase/ScheduleUsecae/get_all_schedule.dart';
import 'package:university/features/AllFeatures/presentation/bloc/SchedulBloc/schedul_bloc.dart';
import 'package:university/core/network/check_network.dart';
import 'package:http/http.dart' as http;

import 'features/AllFeatures/domain/usecase/ScheduleUsecae/notificatin_schedule_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //bloc ===========================
  sl.registerFactory(() => SchedulBloc(
      schedlulenotificationUsecae: sl(), getAllScheduleUsecase: sl()));

  //USECASE ========================
  sl.registerFactory(() => GetAllScheduleUsecase(rerpository: sl()));
  sl.registerFactory(
      () => GetNotificationScheduleUsecase(scheduleRepository: sl()));

  //Repository Imp  ================
  sl.registerLazySingleton<SchedulRepositoryImp>(() => SchedulRepositoryImp(
      localSource: sl(), networkInfo: sl(), remoteSchedul: sl()));

  //Database =======================
  sl.registerLazySingleton<SchedulRemoteDataSource>(
    () => SchedulRemoteDataSourceImp(
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
}
