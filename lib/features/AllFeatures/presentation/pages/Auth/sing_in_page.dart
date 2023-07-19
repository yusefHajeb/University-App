import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:university/core/Utils/lang/app_localization.dart';
import 'package:university/features/AllFeatures/presentation/bloc/authentication/authentication_bloc.dart';
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
                child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    if (state is AuthProgressState) {
                      return FormLoginWidget();
                    } else if (state is AuthErrorState)
                      return Text(state.message.tr(context));
                    return Center(
                      child: Text("try again".tr(context)),
                    );
                  },
                  listener: (context, state) {},
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
