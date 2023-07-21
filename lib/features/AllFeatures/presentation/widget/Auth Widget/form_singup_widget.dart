import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:university/core/Utils/app_space.dart';
import 'package:university/core/Utils/lang/app_localization.dart';
import 'package:university/features/AllFeatures/domain/entites/auth_entites/singin.dart';
import 'package:university/features/AllFeatures/domain/entites/auth_entites/singup.dart';
import 'package:university/features/AllFeatures/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:university/features/AllFeatures/presentation/pages/Auth/singup_page.dart';
import 'package:university/features/AllFeatures/presentation/widget/Auth%20Widget/custom_textfiled.dart';
import 'package:university/features/AllFeatures/presentation/widget/Auth%20Widget/submet_login.dart';

class FormSingUpWidget extends StatefulWidget {
  const FormSingUpWidget({super.key});

  @override
  State<FormSingUpWidget> createState() => _FormSingUpWidgetState();
}

class _FormSingUpWidgetState extends State<FormSingUpWidget>
    with SingleTickerProviderStateMixin {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _recordStd = TextEditingController();
  final TextEditingController _passwordStd = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();

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
                    height: sizeWidth * 1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          blurRadius: 90,
                        ),
                      ],
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(),
                          Text(
                            'SignUp'.tr(context),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(.7),
                            ),
                          ),
                          AppSpaces.verticalSpace10,
                          CustomTextFilde(
                              controller: _email,
                              icon: Icons.email_outlined,
                              hintText: 'Emial..'),
                          CustomTextFilde(
                              controller: _username,
                              icon: Icons.account_circle_outlined,
                              hintText: 'Username ..'),
                          CustomTextFilde(
                              controller: _recordStd,
                              icon: Icons.numbers_outlined,
                              hintText: 'Record Number ..'),
                          CustomTextFilde(
                              controller: _passwordStd,
                              icon: Icons.lock_outline,
                              hintText: 'Password...'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SubmitFormBtn(
                                onPressed: validateFormLogin,
                                btnName: 'SingUp',
                              ),
                              SizedBox(width: sizeWidth / 25),
                              // Container(
                              // width: sizeWidth / 2.6,
                              // alignment: Alignment.center,
                              // child: RichText(
                              //   text: TextSpan(
                              //     text: 'Are You have account !',
                              //     style: TextStyle(color: Colors.blueAccent),
                              //     recognizer: TapGestureRecognizer()
                              //       ..onTap = () {
                              //         Fluttertoast.showToast(
                              //           msg:
                              //               'Forgotten password! button pressed',
                              //         );
                              //       },
                              //   ),
                              // ),
                              // )
                            ],
                          ),
                          SizedBox(),
                          InkWell(
                            onTap: () {
                              BlocProvider.of<AuthenticationBloc>(context)
                                  .add(SingUpEvent());
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (_) => SingUpPage()),
                                  (route) => false);
                            },
                            child: InkWell(
                              onTap: () {
                                return BlocProvider.of<AuthenticationBloc>(
                                        context)
                                    .add(AuthGetStart());
                              },
                              child: RichText(
                                text: TextSpan(
                                  text: 'Are You have account !',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 15,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      return BlocProvider.of<
                                              AuthenticationBloc>(context)
                                          .add(AuthGetStart());
                                      Fluttertoast.showToast(
                                        msg:
                                            'Create a new Account button pressed',
                                      );
                                    },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(),
                        ])))));
  }

  void validateFormLogin() {
    final isValid = _formKey.currentState!.validate();
    final SingUp login = SingUp(
        record: _recordStd.text,
        password: _passwordStd.text,
        email: _email.text,
        token: "2",
        username: _username.text);
    if (isValid) {
      print("$login ============$isValid filed Data");
      BlocProvider.of<AuthenticationBloc>(context)
          .add(SingUpStudentEvent(singUp: login));
    }
  }
}
