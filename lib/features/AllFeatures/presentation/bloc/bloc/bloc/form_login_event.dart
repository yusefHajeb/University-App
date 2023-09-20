part of 'form_login_bloc.dart';

class FormLoginEvent extends Equatable {
  const FormLoginEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
  // FormLoginEvent();
  // @override
  // List<Object> get props => [];
}

// class InitialControllerEvent extends FormLoginEvent {
//   InitialControllerEvent({});
// }

class FormLoginSingInEvent extends FormLoginEvent {
  final Singin login;
  const FormLoginSingInEvent({required this.login});
  @override
  List<Object> get props => [login];
}

class FormValidateLogin extends FormLoginEvent {
  final bool filage;

  const FormValidateLogin({this.filage = false});

  @override
  List<Object> get props => [filage];
}

class FormValidateEvent extends FormLoginEvent {}
