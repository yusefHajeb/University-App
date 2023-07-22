import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/Utils/lang/app_localization.dart';

import '../../cubit/localization/local_cubit_cubit.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting".tr(context)),
      ),
      body: Center(
        child: BlocConsumer<LocaleCubit, ChangeLocalState>(
            listener: (context, state) {
          Navigator.pop(context);
        }, builder: (context, state) {
          return DropdownButton<String>(
            dropdownColor: Colors.white,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            underline: Container(
              height: 2,
              color: Color.fromARGB(255, 14, 30, 44),
            ),
            value: state.locale.languageCode,
            items: ['ar', 'en'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    value,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                // BlocProvider.of<LocaleCubit>(context)
                //     .changeLanguage(newValue);

                context.read<LocaleCubit>().changeLanguage(newValue);
                // Navigator.pop(context);
              }
            },
          );
        }),
      ),
    );
  }
}
