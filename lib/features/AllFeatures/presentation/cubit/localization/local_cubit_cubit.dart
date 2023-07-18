import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

import '../../../../../core/Utils/lang/language_cach.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<ChangeLocalState> {
  LocaleCubit() : super(ChangeLocalState(locale: Locale('en')));
  Future<void> getSavedLanguage() async {
    final String cachedLanguageCode =
        await LanguageCacheHelper().getCachedLanguageCode();
    emit(
      ChangeLocalState(
        locale: Locale(
          cachedLanguageCode,
        ),
      ),
    );
  }

  Future<void> changeLanguage(String languageCode) async {
    await LanguageCacheHelper().cachedLanguageCode(languageCode);

    emit(
      ChangeLocalState(
        locale: Locale(
          languageCode,
        ),
      ),
    );
  }
}
