import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:university/chat/domain/entities/student_entity.dart';
import 'package:university/chat/domain/use_cases/forgot_password_usecase.dart';
import 'package:university/chat/domain/use_cases/get_create_current_user_usecase.dart';
import 'package:university/chat/domain/use_cases/sign_in_usecase.dart';
import 'package:university/chat/domain/use_cases/sign_up_usecase.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final GetCreateCurrentUserUseCase getCreateCurrentUserUseCase;

  CredentialCubit(
      {required this.signUpUseCase,
      required this.signInUseCase,
      required this.forgotPasswordUseCase,
      required this.getCreateCurrentUserUseCase})
      : super(CredentialInitial());

  Future<void> forgotPassword({required String email}) async {
    try {
      await forgotPasswordUseCase.call(email);
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> signInSubmit({
    required String email,
    required String password,
    required int record,
  }) async {
    emit(CredentialLoading());
    try {
      if (await signInUseCase.call(new StudentEntity(
          std_record: record, std_password: password, std_email: email))) {
        emit(CredentialSuccess(new StudentEntity(
            std_record: record, std_password: password, std_email: email)));
      } else if (!(await signInUseCase.call(new StudentEntity(
          std_record: record, std_password: password, std_email: email)))) {
        emit(CredentialFailure());
      }
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> googleAuthSubmit() async {
    emit(CredentialLoading());
    try {
      // await googleSignInUseCase.call();
      // emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> signUpSubmit({required StudentEntity user}) async {
    emit(CredentialLoading());
    try {
      print(user);
      // await signUpUseCase.call(user);
      await getCreateCurrentUserUseCase.call(user);
      emit(CredentialSuccess(user));
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }
}
