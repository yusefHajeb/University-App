import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:university/core/Utils/box_decoration.dart';
import 'package:university/core/value/app_space.dart';
import 'package:university/core/Utils/lang/app_localization.dart';
import 'package:university/core/value/style_manager.dart';
import 'package:university/core/widget/flutter_toast.dart';
import 'package:university/features/AllFeatures/domain/entites/auth_entites/singin.dart';
import 'package:university/features/AllFeatures/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:university/features/AllFeatures/presentation/pages/application_page.dart';
import 'package:university/main.dart';

import '../../../../../core/color/app_color.dart';
import '../../../../../core/widget/custom_input.dart';
import '../profile_widget/text_autline.dart';

class FormLoginWidget extends StatefulWidget {
  const FormLoginWidget({super.key});

  @override
  State<FormLoginWidget> createState() => _FormLoginWidgetState();
}

class _FormLoginWidgetState extends State<FormLoginWidget>
    with SingleTickerProviderStateMixin {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _recordStd = TextEditingController();
  final TextEditingController _passwordStd = TextEditingController();
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _transform;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )..addListener(() {
        setState(() {});
      });

    _transform = Tween<double>(begin: 2, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );

    _controller.forward();
    _formKey = GlobalKey<FormState>();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _opacity.removeListener(() {});
    _transform.isDismissed;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    final sizeWidth = ScreenUtil().screenWidth;

    return Form(
        key: _formKey,
        child: Opacity(
            opacity: _opacity.value,
            child: Transform.scale(
                scale: _transform.value,
                child: Container(
                    width: sizeWidth * .9,
                    height: sizeWidth * .9,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecorationStyles.headerTab,
                    // decoration: BoxDecoration(
                    //   color: Colors.white,
                    //   borderRadius: BorderRadius.circular(15),
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.black.withOpacity(.1),
                    //       blurRadius: 90,
                    //     ),
                    //   ],
                    // ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(),
                          Text('SignUp'.tr(context),
                              style: getFontNormal(
                                  15, FontWeight.w600, AppColors.white)),
                          AppSpaces.verticalSpace10,
                          LabelledFormInput(
                              hint: "ادخل رقم القيد الجامعي",
                              controller: _recordStd,
                              label: " رقم القيد :",
                              isNumber: true,
                              placeholder: ""),

                          LabelledFormInput(
                              hint: " ادخل كلمة المرور",
                              controller: _passwordStd,
                              label: "كلمة المرور :",
                              placeholder: ""),
                          // CustomTextFilde(
                          //     controller: _recordStd,
                          //     icon: Icons.account_circle_outlined,
                          //     hintText: 'Record Number..'.tr(context)),
                          // CustomTextFilde(
                          //     controller: _passwordStd,
                          //     icon: Icons.lock_outline,
                          //     hintText: 'Password...'.tr(context)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButtonWithText(
                                content: 'LOGIN'.tr(context),
                                width: 146,
                                onPressed: validateFormLogin,
                              ),
                              // SubmitFormBtn(
                              //   onPressed: validateFormLogin,
                              //   btnName: 'LOGIN'.tr(context),
                              // ),
                              SizedBox(width: sizeWidth / 25),
                              Container(
                                width: sizeWidth / 2.6,
                                alignment: Alignment.center,
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Forgotten password!'.tr(context),
                                    style: getFontNormal(13, FontWeight.w400,
                                        AppColors.underLine),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        toastInfo(
                                          msg:
                                              'Forgotten password! button pressed',
                                        );
                                        //  bool     Global.storgeServece.setBool(
                                        //           Constants.STORGE_USER_LOGED_FIRST,
                                        //           false);
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  ApplicationPage()),
                                        );
                                      },
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(),
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.of(context).pushReplacement(
                          //       MaterialPageRoute(
                          //           builder: (_) => ApplicationPage()),
                          //     );
                          //     // return BlocProvider.of<AuthenticationBloc>(
                          //     //         context)
                          //     //     .add(SingUpEvent());

                          //     // Navigator.of(context).pushAndRemoveUntil(
                          //     //     MaterialPageRoute(
                          //     //         builder: (_) => SingUpPage()),
                          //     //     (route) => false);
                          //   },
                          //   child: RichText(
                          //     text: TextSpan(
                          //       text: 'Create a new Account',
                          //       style: getFontNormal(15, FontWeightManager.bold,
                          //           AppColors.underLine),
                          //       recognizer: TapGestureRecognizer()
                          //         ..onTap = () {
                          //           BlocProvider.of<AuthenticationBloc>(context)
                          //               .add(SingUpEvent());
                          //           // Navigator.of(context).pushAndRemoveUntil(
                          //           //     MaterialPageRoute(
                          //           //         builder: (_) => SingUpPage()),
                          //           //     (route) => false);
                          //           Fluttertoast.showToast(
                          //             msg: 'Create a new SingUp Now ',
                          //           );
                          //         },
                          //     ),
                          //   ),
                          // ),
                          SizedBox(),
                        ])))));
  }

  void validateFormLogin() {
    if (socket.connected) {
      print("recored and password");
      print(_recordStd.text);
      print(_passwordStd.text);
      final isValid = _formKey.currentState!.validate();
      final Singin login = Singin(
        record: _recordStd.text,
        password: _passwordStd.text,
      );
      if (isValid) {
        print("$login ============$isValid filed Data");

        BlocProvider.of<AuthenticationBloc>(context)
            .add(SingInStudintEvent(singIn: login));
      }
    } else {
      toastInfo(msg: "يرجى فحص الاتصال بالشبكة");
    }
  }
}
