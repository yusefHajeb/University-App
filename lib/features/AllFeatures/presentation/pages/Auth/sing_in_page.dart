import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:university/core/Utils/lang/app_localization.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/core/function/messages.dart';
import 'package:university/core/widget/flutter_toast.dart';
import 'package:university/features/AllFeatures/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:university/features/AllFeatures/presentation/pages/Auth/singup_page.dart';
import 'package:university/features/AllFeatures/presentation/pages/application_page.dart';
import 'package:university/features/AllFeatures/presentation/widget/Auth%20Widget/form_login_widget.dart';
import '../../../../../core/color/app_color.dart';
import '../../../../../core/value/global.dart';
import '../../../../../core/widget/loading_widget.dart';

class SingInPage extends StatelessWidget {
  const SingInPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    final sizeHeight = ScreenUtil().screenHeight;

    return Scaffold(
        body: ScrollConfiguration(
            behavior: MyBehavior(),
            child: Container(
              color: AppColors.backgroundPages,
              child: SizedBox(
                height: sizeHeight,
                child: Container(
                  alignment: Alignment.center,
                  // color: AppColors.backgroundPages,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.backgroundPages,

                        // AppColors.backgroundPages,
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
                        // return SizedBox();
                      }
                      // else if (state is AuthSuccessState) {
                      // return LoadingCircularProgress();
                      // }
                      else if (state is AuthErrorState) {
                        return FormLoginWidget();
                      }
                      return LoadingCircularProgress();
                    },
                    listener: (context, state) {
                      if (state is AuthSuccessState) {
                        print("SingUpSuccessState");
                        toastInfo(
                          msg: (singInSuccessfuly).tr(context),
                        );
                        Global.storgeServece
                            .setBool(Constants.STORGE_USER_LOGED_FIRST, true);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ApplicationPage()),
                            (route) => false);
                      } else if (state is AuthErrorState) {
                        toastInfo(msg: (state.message).tr(context));
                        // Fluttertoast.showToast(
                        //   msg: (state.message).tr(context),
                        // );
                      } else if (state is SingUpState) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => SingUpPage()),
                            (route) => false);
                      }
                    },
                  ),
                ),
              ),
            )));
  }
}

class MyBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
