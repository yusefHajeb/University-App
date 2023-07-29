import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/color/app_color.dart';
import 'package:university/core/value/margin_manager.dart';
import '../../../../../core/value/style_manager.dart';
import '../../cubit/localization/local_cubit_cubit.dart';

class ChangeLang extends StatelessWidget {
  const ChangeLang({
    Key? key,
    required this.localCubit,
  }) : super(key: key);

  final LocaleCubit localCubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<LocaleCubit, ChangeLocalState>(
          bloc: localCubit,
          listener: (context, state) {
            Navigator.pop(context);
          },
          builder: (context, state) {
            return DropdownButton<String>(
                dropdownColor: Colors.white,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: bigHeaderEn(
                    color: AppColors.backgroundPages, fontSize: AppSize.s18),
                underline: Container(
                  height: 2,
                  color: AppColors.backgroundPages,
                ),
                value: state.locale.languageCode,
                items:
                    ['ar', 'en'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    alignment: Alignment.center,
                    child: Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 10),
                      child: Text(value,
                          style: bigHeaderEn(
                              color: AppColors.backgroundPages,
                              fontSize: AppSize.s18)),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    BlocProvider.of<LocaleCubit>(context)
                        .changeLanguage(newValue);
                  }
                });
          }),
    );
  }
}
