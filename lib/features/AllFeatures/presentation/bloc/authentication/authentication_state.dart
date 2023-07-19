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

class AuthErrorState extends AuthenticationState {
  final String message;

  const AuthErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

class LoadingAuthState extends AuthenticationState {}

class LogingState extends AuthenticationState {}

class ForgetPasswordSatet extends AuthenticationState {}
