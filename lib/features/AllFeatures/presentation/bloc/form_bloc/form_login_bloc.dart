// import 'dart:js';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:university/core/value/global.dart';

import '../../../domain/entites/auth_entites/singin.dart';
part 'form_login_event.dart';
part 'form_login_state.dart';

class FormLoginBloc extends Bloc<FormLoginEvent, FormLoginState> {
  // TextEditingController controllerName = TextEditingController();
  // TextEditingController controllerPassword = TextEditingController();
  // GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FormLoginBloc()
      : super(FormLoginInitial(
          controllerName: TextEditingController(),
          controllerPassword: TextEditingController(),
          formKey: GlobalKey<FormState>(),
        )) {
    on<FormLoginEvent>((event, emit) {
      if (state is FormLoginSingInEvent) {
        // emit(validateFormLogin(formKey, controllerName, controllerPassword));
        emit(FormLoginState(
          controllerName: state.controllerName,
          controllerPassword: state.controllerPassword,
          formKey: state.formKey,
        ));
      }
    });
  }
  validateFormLogin(
      GlobalKey<FormState> formKey,
      TextEditingController contTextName,
      TextEditingController contTextPassword) {
    // bool fige = await Global.storgeServece.checkNetWork();
    // bool x = await netWork.isConnected == true ? true : false;
    final isValid = formKey.currentState!.validate();

    // final Singin login = Singin(
    //   record: contTextName.text,
    //   password: contTextPassword.text,
    // );

    // BlocProvider.of<FormLoginBloc>(await Global.storgeServece.getContext())
    //     .add(FormValidateLogin(filage: isValid));

    //   if (fige) {
    //     print("$fige =================== No Internet");
    //     if (isValid) {
    //       print("$login ============$isValid filed Data");
    //       BlocProvider.of<FormLoginBloc>(context)
    //           .add(FormLoginEvent(login: login));
    //       print("$login =================== true");
    //     } else {
    //       print(" =================== validate fasle");
    //     }
    //   } else {
    //     {
    //       print("no Internt");
    //     }
    //   }
  }
}
