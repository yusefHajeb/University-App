import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/core/fonts/app_fonts.dart';
import 'package:university/core/value/app_space.dart';
import 'package:university/core/value/global.dart';
import 'package:university/features/AllFeatures/presentation/widget/Auth%20Widget/submet_login.dart';
import '../../../../../core/color/app_color.dart';
import '../../../../../core/value/style_manager.dart';
import '../../../../../core/widget/custom_input.dart';
import '../../../domain/entites/auth_entites/singin.dart';
import '../../bloc/form_bloc/form_login_bloc.dart';
import '../../pages/application_page.dart';

class FormeSingIn extends StatelessWidget {
  const FormeSingIn({super.key});

  // }

  Widget build(BuildContext context) {
    Future<void> validateFormLogin(GlobalKey<FormState> formKey,
        String contTextName, String contTextPassword) async {
      bool fige = await Global.storgeServece.checkNetWork();
      // bool x = await netWork.isConnected == true ? true : false;
      final isValid = formKey.currentState!.validate();
      final Singin login = Singin(
        record: contTextName,
        password: contTextPassword,
      );

      print("$fige =================== No Internet");
      if (isValid) {
        print("$login ============$isValid filed Data");
        // BlocProvider.of<FormLoginBloc>(context)
        //     .add(FormLoginEvent(login: login));
        print("$login =================== true");
      } else {
        print(" =================== validate fasle");
      }
    }

    return BlocConsumer<FormLoginBloc, FormLoginState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        // ignore: unnecessary_type_check
        if (state is FormLoginState)
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: state.formKey,
              child: Container(
                  width: appSize(context).width * .7,
                  color: AppColors.white,
                  height: appSize(context).height * .5,
                  child: Column(
                    children: [
                      Text("Login ",
                          style: getBoldStyleEn(color: AppColors.darkGrey)
                              .copyWith(fontSize: FontSize.s16)),
                      AppSpaces.verticalSpace20,
                      LabelledFormInput(
                          hint: "رقم القيد",
                          controller: state.controllerName,
                          label: "الاسم",
                          placeholder: ""),
                      AppSpaces.verticalSpace10,
                      LabelledFormInput(
                          hint: "رقم القيد",
                          controller: state.controllerPassword,
                          label: "الاسم",
                          placeholder: ""),
                      // CustomTextFilde(
                      //   isPassword: true,
                      //   controller: state.controllerPassword,
                      //   hintText: 'Enter Password..',
                      //   icon: Icons.account_circle_outlined,
                      // ),
                      AppSpaces.verticalSpace20,
                      Row(
                        children: [
                          SubmitFormBtn(
                              onPressed: () =>
                                  state.formKey.currentState!.validate(),
                              btnName: "Login"),
                          TextButton(
                              child: Text("SingUp"),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (_) => ApplicationPage()),
                                );
                                print(
                                    "\n  ${state.controllerName} ======== name");
                                print(
                                    "\n  ${state.controllerPassword} ======== password");
                              })
                        ],
                      )
                    ],
                  )),
            ),
          );
        else
          return SizedBox();
      },
    );
  }
}
