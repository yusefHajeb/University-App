import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale? local;

  AppLocalizations({this.local});

  static AppLocalizations? of(BuildContext context) {
    // tell flutter this Class to localization by the return
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _appLocalizationsDelegate();
  late Map<String, String> _localizationStrings;

  Future loadJsonLanguage() async {
    String jsonString =
        await rootBundle.loadString('assets/lang/${local!.languageCode}.json');

    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizationStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  String translate(String key) => _localizationStrings[key] ?? "";
}

class _appLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _appLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(local: locale);
    await localizations.loadJsonLanguage();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}

extension TranslateX on String {
  String tr(BuildContext context) {
    return AppLocalizations.of(context)!.translate(this);
  }
}
