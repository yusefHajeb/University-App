import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:university/core/Utils/lang/app_localization.dart';
import 'package:university/core/function/messages.dart';
import 'package:university/features/AllFeatures/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:university/features/AllFeatures/presentation/pages/Auth/singup_page.dart';
import 'package:university/features/AllFeatures/presentation/pages/onboarding/onboarding_start.dart';
import 'package:university/features/AllFeatures/presentation/widget/Auth%20Widget/form_login_widget.dart';
import '../../../../../core/color/app_color.dart';

class SingInPage extends StatelessWidget {
  const SingInPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    final sizeWidth = ScreenUtil().screenWidth;
    final sizeHeight = ScreenUtil().screenHeight;

    return Scaffold(
        body: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
                child: SizedBox(
              height: sizeHeight,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.backgroundPages,
                      AppColors.darkRadialBackground,
                    ],
                  ),
                ),
                // child: FormLoginWidget(),
                child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    print("===============bloc");
                    if (state is AuthProgressState) {
                      print("==============if");
                      return FormLoginWidget();
                    }
                    if (state is SingUpState) {
                      print("======== you in state singup ==============");
                      // return FormSingUpWidget();
                    } else if (state is AuthSuccessState) {
                      return Center(child: CircularProgressIndicator());
                    }
                    print("==============else");
                    return Center(
                        child: CircularProgressIndicator(
                            backgroundColor: Color.fromARGB(0, 239, 140, 87)));
                  },
                  listener: (context, state) {
                    if (state is AuthSuccessState) {
                      Fluttertoast.showToast(
                        msg: (singInSuccessfuly).tr(context),
                      );
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (_) => OnboardingCarousel()),
                          (route) => false);
                    } else if (state is AuthErrorState) {
                      Fluttertoast.showToast(
                        msg: (state.message).tr(context),
                      );
                    } else if (state is SingUpState) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => SingUpPage()),
                          (route) => false);
                    }
                  },
                ),
              ),
            ))));
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
