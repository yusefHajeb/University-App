part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthGetStart extends AuthenticationEvent {}

class LoginStudintEvent extends AuthenticationEvent {}

class SingUpStudentEvent extends AuthenticationEvent {
  final SingUp singUp;

  SingUpStudentEvent({required this.singUp});
  @override
  List<Object> get props => [singUp];
}

class SingInStudintEvent extends AuthenticationEvent {
  final Singin singIn;

  SingInStudintEvent({required this.singIn});
  @override
  List<Object> get props => [singIn];
}

class SingInSuccessEvent extends AuthenticationEvent {
  final Singin singIn;

  SingInSuccessEvent({required this.singIn});
  @override
  List<Object> get props => [singIn];
}

class SingUpEvent extends AuthenticationEvent {}

class AuthErrorSingInEvent extends AuthenticationEvent {}

class UpdateDataUser extends AuthenticationEvent {
  final SingUp user;

  UpdateDataUser({required this.user});
}
