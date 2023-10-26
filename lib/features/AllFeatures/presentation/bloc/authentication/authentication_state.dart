part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthProgressState extends AuthenticationState {}

class AuthSuccessState extends AuthenticationState {
  final String message;

  const AuthSuccessState({required this.message});
  @override
  List<Object> get props => [message];
}

class SingUpSuccessState extends AuthenticationState {
  final String message;
  final SingUp singUp;

  const SingUpSuccessState({required this.message, required this.singUp});
  List<Object> get props => [message, singUp];
}

class AuthErrorState extends AuthenticationState {
  final String message;

  const AuthErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

class LoadingAuthState extends AuthenticationState {}

class ForgetPasswordSatet extends AuthenticationState {}

class SingUpState extends AuthenticationState {}

class SingInState extends AuthenticationState {}
