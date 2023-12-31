import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:university/core/function/messages.dart';

import 'package:university/features/AllFeatures/domain/entites/auth_entites/singup.dart';
import 'package:university/features/AllFeatures/domain/usecase/auth_singin_singup.dart/singin_usecase.dart';
import 'package:university/features/AllFeatures/domain/usecase/auth_singin_singup.dart/singup_usecase.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/function/failure_to_message.dart';
import '../../../domain/entites/auth_entites/singin.dart';
import '../../../domain/usecase/auth_singin_singup.dart/update_data_user.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SingInUsecase singInUsecase;
  final SingUpUsecase singUpUsecase;
  final UpdateDataUserUsecase updateUserData;
  AuthenticationBloc(
      {required this.updateUserData,
      required this.singInUsecase,
      required this.singUpUsecase})
      : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is AuthGetStart) {
        emit(AuthProgressState());
        // emit(AuthSuccessState(message: "Login "));
      } else if (event is LoginStudintEvent) {
        emit(LoadingAuthState());
        // emit(AuthSuccessState(message: "Login "));
      } else if (event is SingInStudintEvent) {
        print("SingIn State in Bloc");
        emit(LoadingAuthState());
        final singIn = await singInUsecase(event.singIn);
        print(singIn);
        emit(_failureOrSingInState(singIn, singInSuccessfuly));
      } else if (event is SingUpStudentEvent) {
        emit(LoadingAuthState());
        final singUp = await singUpUsecase(event.singUp);
        emit(_failureOrSingUpnState(singUp, singUpSuccessfuly));
      } else if (event is SingUpEvent) {
        emit(SingUpState());
      } else if (event is UpdateDataUser) {
        final update = await updateUserData(event.user);
        update.fold(
            (failure) =>
                emit(AuthErrorState(message: failureToMessage(failure))),
            (response) => emit(AuthSuccessState(message: singUpSuccessfuly)));
        // emit(_failureOrSingUpnState(update, singUpSuccessfuly));
      }
    });
  }

  AuthenticationState _failureOrSingInState(
      Either<Failure, SingUp> either, String message) {
    return either
        .fold((failure) => AuthErrorState(message: failureToMessage(failure)),
            (singIn) {
      // final data = Global.storgeServece.getStringData("STUDEN_DATA");
      print("data");
      // print(data);
      return AuthSuccessState(message: message);
    });
  }

  AuthenticationState _failureOrSingUpnState(
      Either<Failure, SingUp> either, String message) {
    return either
        .fold((failure) => AuthErrorState(message: failureToMessage(failure)),
            (singUp) {
      return SingUpSuccessState(message: message, singUp: singUp);
    });
  }

  // AuthenticationState _failureOrSingUpState()
}
