part of 'form_login_bloc.dart';

// ignore: must_be_immutable
class FormLoginState extends Equatable {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Singin? singIn;
  FormLoginState(
      {required this.controllerName,
      required this.controllerPassword,
      required this.formKey,
      this.singIn});

  @override
  List<Object> get props => [controllerName, controllerPassword, formKey];
}

// ignore: must_be_immutable
class FormLoginInitial extends FormLoginState {
  FormLoginInitial(
      {required super.controllerName,
      required super.controllerPassword,
      required super.formKey,
      super.singIn});
}

// class FomrLoadingState extends FormLoginState {
//   FomrLoadingState(
//       {required super.controllerName,
//       required super.controllerPassword,
//       required super.formKey,
//       required super.singIn});
// }
