import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:university/features/AllFeatures/domain/entites/auth_entites/login.dart';
import 'package:university/features/AllFeatures/domain/usecase/auth_singin_singup.dart/singin_usecase.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/function/failure_to_message.dart';
import '../../../domain/entites/auth_entites/singin.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SingInUsecase singInUsecase;
  AuthenticationBloc({required this.singInUsecase})
      : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is AuthGetStart) {
        emit(AuthProgressState());
      } else if (event is LoginStudintEvent) {
        emit(LogingState());
        Duration(minutes: 1);
        emit(AuthSuccessState(message: "Success"));
      } else if (event is SingInSuccessEvent) {
        emit(LoadingAuthState());
        final singIn = await singInUsecase(event.singIn);
        emit(_failureOrSingInState(singIn));
      }
    });
  }

  AuthenticationState _failureOrSingInState(Either<Failure, Singin> either) {
    return either.fold(
        (failure) => AuthErrorState(message: failureToMessage(failure)),
        (login) => AuthSuccessState(message: ""));
  }

  // AuthenticationState _failureOrSingUpState()
}
