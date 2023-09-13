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
  final Singin singIn;
  AuthSuccessState({required this.singIn, required this.message});
  @override
  List<Object> get props => [message, singIn];
}

class SingUpSuccessState extends AuthenticationState {}

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
