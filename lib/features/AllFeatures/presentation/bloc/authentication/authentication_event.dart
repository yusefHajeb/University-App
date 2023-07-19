part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthGetStart extends AuthenticationEvent {}

class LoginStudintEvent extends AuthenticationEvent {}

class SingInStudintEvent extends AuthenticationEvent {}
