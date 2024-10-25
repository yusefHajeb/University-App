import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/chat/domain/entities/student_entity.dart';
import 'package:university/chat/domain/use_cases/get_current_uid_usecase.dart';
// import 'package:university/chat/domain/use_cases/get_current_uid_usecase.dart';
import 'package:university/chat/domain/use_cases/is_sign_in_usecase.dart';
import 'package:university/chat/domain/use_cases/sign_out_usecase.dart';
import 'package:university/chat/domain/use_cases/store_token_student.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsSignInUseCase isSignInUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUIDUseCase getCurrentUIDUseCase;
  final SharedPreferences prefs;
  final StoreTokenUseCase storeTokenUseCase;
  AuthCubit(
      {required this.isSignInUseCase,
      required this.prefs,
      required this.signOutUseCase,
      required this.getCurrentUIDUseCase,
      required this.storeTokenUseCase})
      : super(AuthInitial());

  Future<void> appStarted() async {
    print("you are in Chat");
    try {
      await initPlatform();
      // prefs.clear();
      bool isSignIn = await isSignInUseCase.call();
      if (isSignIn == true) {
        final uid = new StudentEntity(
          std_name: prefs.getString("std_name")!,
          batch_id: prefs.getInt("batch_id")!,
          t_id: prefs.getInt("std_id")!,
          std_image: prefs.getString("std_image")!,
        );
        print("haved {$uid}");
        emit(Authenticated(uid: uid));
      } else
        emit(UnAuthenticated());
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn(StudentEntity std) async {
    try {
      final uid = await getCurrentUIDUseCase.call(new StudentEntity(
          std_email: std.std_email,
          std_password: std.std_password,
          std_record: std.std_record));
      print(uid.std_name);
      // bool resulte = await storeTokenUseCase.call(uid.t_id);
      print("user Id $uid");
      emit(Authenticated(uid: uid));
    } catch (_) {
      print("user Id null");
      emit(UnAuthenticated());
    }
  }

  Future<void> initPlatform() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId("807c33a1-ca9c-4790-9d80-0cfa7e2904d0");
    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((value) => {print(value)});
    OneSignal.shared.getDeviceState().then((value) => {
          print("initPlatform the token is: "),
          print(value!.userId),
          prefs.setString("token", value.userId ?? ""),
        });
  }

  Future<void> loggedOut() async {
    try {
      await signOutUseCase.call();
      emit(UnAuthenticated());
    } catch (_) {
      emit(UnAuthenticated());
    }
  }
}
