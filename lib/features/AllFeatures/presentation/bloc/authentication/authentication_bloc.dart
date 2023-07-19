import 'dart:js';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:university/features/AllFeatures/domain/entites/auth_entites/login.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/function/failure_to_message.dart';
import '../../../domain/entites/auth_entites/singin.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {
      if (event is AuthGetStart) {
        emit(AuthProgressState());
        emit(AuthErrorState(message: ""));
      } else if (event is LoginStudintEvent) {
        emit(LogingState());
        
      }else if(event is )
    });
  }

  AuthenticationState _failureOrSchedualToState(
      Either<Failure, List<Login>> either) {
    return either.fold(
        (failure) => AuthErrorState(message: failureToMessage(failure)),
        (login) => AuthSuccessState(message: ""));
  }
}
