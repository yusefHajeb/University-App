import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/Utils/lang/app_localization.dart';
import 'package:university/features/AllFeatures/presentation/bloc/authentication/authentication_bloc.dart';

class SingInPage extends StatelessWidget {
  const SingInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthErrorState) {
            return Text(state.message.tr(context));
          }
          return SizedBox();
        },
        listener: (context, state) {},
      ),
    );
  }
}
