// import 'package:dartz/dartz_streaming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/chat/data/remote/data_sources/DataAccess.dart';
import 'package:university/chat/data/remote/data_sources/Database_Remote_Data_Source.dart';
import 'package:university/chat/data/remote/data_sources/Database_Remote_Data_Source_Impl.dart';
import 'package:university/chat/data/repositories/Database_Remote_Repository.dart';
import 'package:university/chat/domain/repositories/database_Repositorys.dart';
import 'package:university/chat/domain/use_cases/count_number_noseen_usecase.dart';
import 'package:university/chat/domain/use_cases/delete_message_usecase.dart';
import 'package:university/chat/domain/use_cases/forgot_password_usecase.dart';
import 'package:university/chat/domain/use_cases/get_all_group_usecase.dart';
import 'package:university/chat/domain/use_cases/get_all_users_usecase.dart';
import 'package:university/chat/domain/use_cases/get_create_current_user_usecase.dart';
import 'package:university/chat/domain/use_cases/get_current_uid_usecase.dart';
import 'package:university/chat/domain/use_cases/get_messages_usecase.dart';
import 'package:university/chat/domain/use_cases/get_update_user_usecase.dart';
import 'package:university/chat/domain/use_cases/is_sign_in_usecase.dart';
import 'package:university/chat/domain/use_cases/send_file_messag_usecase.dart';
import 'package:university/chat/domain/use_cases/send_text_message_usecase.dart';
import 'package:university/chat/domain/use_cases/sign_in_usecase.dart';
import 'package:university/chat/domain/use_cases/sign_out_usecase.dart';
import 'package:university/chat/domain/use_cases/sign_up_usecase.dart';
import 'package:university/chat/domain/use_cases/store_token_student.dart';
import 'package:university/chat/domain/use_cases/update_group_usecase.dart';
import 'package:university/chat/domain/use_cases/update_text_message.dart';
import 'package:university/chat/presentation/cubit/auth/auth_cubit.dart';
import 'package:university/chat/presentation/cubit/bottom_chat/bottom_chat_cubit.dart';
import 'package:university/chat/presentation/cubit/chat/chat_cubit.dart';
import 'package:university/chat/presentation/cubit/count_new_message/count_new_message_cubit.dart';
import 'package:university/chat/presentation/cubit/credential/credential_cubit.dart';
import 'package:university/chat/presentation/cubit/group/group_cubit.dart';
import 'package:university/chat/presentation/cubit/image_cubit/image_cubit.dart';
import 'package:university/chat/presentation/cubit/user/user_cubit.dart';
import 'package:university/core/network/check_network.dart';
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
import 'package:http/http.dart' as http;
import 'package:university/features/AllFeatures/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:university/features/AllFeatures/presentation/bloc/lading_page/lading_page_bloc.dart';
import 'package:university/features/AllFeatures/presentation/bloc/notifications/notefications_bloc.dart';
import 'package:university/features/AllFeatures/presentation/bloc/search_books/search_books_bloc.dart';
import 'package:university/generated/Links.dart';
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
import '../generated/Netwrok.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

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

  sl.registerFactory<AuthCubit>(() => AuthCubit(
      isSignInUseCase: sl.call(),
      signOutUseCase: sl.call(),
      storeTokenUseCase: sl.call(),
      getCurrentUIDUseCase: sl.call(),
      prefs: sl.call()));
  sl.registerFactory<CredentialCubit>(() => CredentialCubit(
        forgotPasswordUseCase: sl.call(),
        getCreateCurrentUserUseCase: sl.call(),
        signInUseCase: sl.call(),
        signUpUseCase: sl.call(),
      ));
  sl.registerFactory<UserCubit>(() => UserCubit(
        getAllUsersUseCase: sl.call(),
        getUpdateUserUseCase: sl.call(),
      ));

  sl.registerFactory<GroupCubit>(() => GroupCubit(
        getAllGroupsUseCase: sl.call(),
        groupUseCase: sl.call(),
      ));
  sl.registerFactory<BottomChatCubit>(() => BottomChatCubit());
  sl.registerFactory<ChatCubit>(() => ChatCubit(
      getMessageUseCase: sl.call(),
      sendTextMessageUseCase: sl.call(),
      sendfileMessageUseCase: sl.call(),
      updateMyTextMessage: sl.call(),
      deleteMyTextMessage: sl.call()));

  sl.registerFactory<ImageCubit>(() => ImageCubit());
  sl.registerFactory<CountNewMessageCubit>(() => CountNewMessageCubit(
      countnumberNoseenUsecase: sl.call(), prefs: sl.call()));

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

  //==========================
  //UseCases
  sl.registerLazySingleton<SendFileMessageUseCase>(
      () => SendFileMessageUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateMyTextMessage>(
      () => UpdateMyTextMessage(repository: sl.call()));
  sl.registerLazySingleton<DeleteMyTextMessage>(
      () => DeleteMyTextMessage(repository: sl.call()));
  sl.registerLazySingleton<StoreTokenUseCase>(
      () => StoreTokenUseCase(repository: sl.call()));
  sl.registerLazySingleton<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCreateCurrentUserUseCase>(
      () => GetCreateCurrentUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUIDUseCase>(
      () => GetCurrentUIDUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetAllUsersUseCase>(
      () => GetAllUsersUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetUpdateUserUseCase>(
      () => GetUpdateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetAllGroupsUseCase>(
      () => GetAllGroupsUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateGroupUseCase>(
      () => UpdateGroupUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetMessageUseCase>(
      () => GetMessageUseCase(repository: sl.call()));
  sl.registerLazySingleton<SendTextMessageUseCase>(
      () => SendTextMessageUseCase(repository: sl.call()));
  sl.registerLazySingleton<CountnumberNoseenUsecase>(
      () => CountnumberNoseenUsecase(repository: sl.call()));
  sl.registerLazySingleton<DatabaseRepository>(
      () => DatabaseRemoteDataSourceImpl(remoteDataSource: sl.call()));

  // sl.registerLazySingleton<SocketInfoImpl>(() => SocketInfoImpl(sl()));

  // sl.registerLazySingleton<NetworkInfoSocket>(() => SocketInfoImpl(sl()));

  //Remote DataSource
  sl.registerLazySingleton<DatabaseRemoteDataSource>(
      () => databaseRemoteDataSourceImpl(
            crud: sl.call(),
            prefs: sl.call(),
            networkinfo: sl.call(),
            socket: sl.call(),
          ));
  final Crud = DataAccessCrud();
  var socket = IO.io('${ServerIp}:3000', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  sl.registerLazySingleton<NetworkInfoSocket>(
      () => SocketInfoImpl(socket: sl()));

  sl.registerLazySingleton<IO.Socket>(() => socket.connect());
  sl.registerLazySingleton(() => Crud);
}
