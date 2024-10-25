import 'dart:io';

import 'package:get_it/get_it.dart';
//import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:university/chat/data/remote/data_sources/DataAccess.dart';
import 'package:university/chat/data/remote/data_sources/Database_Remote_Data_Source.dart';
import 'package:university/chat/data/remote/data_sources/Database_Remote_Data_Source_Impl.dart';
import 'package:university/chat/data/repositories/Database_Remote_Repository.dart';
import 'package:university/chat/domain/repositories/database_Repositorys.dart';
import 'package:university/chat/domain/use_cases/Count_number_noseen_usecase.dart';
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
import 'package:university/chat/presentation/cubit/bottom_chat/bottom_chat_cubit.dart';
import 'package:university/chat/presentation/cubit/chat/chat_cubit.dart';
import 'package:university/chat/presentation/cubit/count_new_message/count_new_message_cubit.dart';
import 'package:university/chat/presentation/cubit/credential/credential_cubit.dart';
import 'package:university/chat/presentation/cubit/group/group_cubit.dart';
import 'package:university/chat/presentation/cubit/image_cubit/image_cubit.dart';
import 'package:university/chat/presentation/cubit/user/user_cubit.dart';
import 'package:university/core/constant/varibal.dart';

// import 'package:university/core/network/check_network.dart';
import 'package:university/generated/Netwrok.dart';

import 'chat/presentation/cubit/auth/auth_cubit.dart';
// import 'package:university/generated/Links.dart';
// import 'package:university/generated/Netwrok.dart';
// import 'features/domain/use_cases/forgot_password_usecase.dart';
// import 'features/domain/use_cases/is_sign_in_usecase.dart';
// import 'features/domain/use_cases/sign_in_usecase.dart';
// import 'features/domain/use_cases/sign_out_usecase.dart';
// import 'features/domain/use_cases/sign_up_usecase.dart';
// import 'features/presentation/cubit/auth/auth_cubit.dart';
// import 'features/presentation/cubit/chat/chat_cubit.dart';
// import 'features/presentation/cubit/credential/credential_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Future bloc
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

  // sl.registerFactory<VideoMessageCubit>(() => VideoMessageCubit(

  // ));

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

  //Repository
  sl.registerLazySingleton<DatabaseRepository>(
      () => DatabaseRemoteDataSourceImpl(remoteDataSource: sl.call()));

  //Remote DataSource
  sl.registerLazySingleton<DatabaseRemoteDataSource>(
      () => databaseRemoteDataSourceImpl(
            crud: sl.call(),
            prefs: sl.call(),
            networkinfo: sl.call(),
            socket: sl.call(),
          ));

  //Exte  rnal
  final Crud = DataAccessCrud();
  var socket = IO.io('${Constants.serverIp}:3000', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  final NetworkInfoSocket networkInfo;
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  sl.registerLazySingleton<NetworkInfoSocket>(
      () => SocketInfoImpl(socket: sl.call()));
  sl.registerLazySingleton(() => prefs);
  sl.registerLazySingleton(() => Crud);
  sl.registerLazySingleton<IO.Socket>(() => socket.connect());
}
