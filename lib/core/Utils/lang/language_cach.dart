import 'package:shared_preferences/shared_preferences.dart';

class LanguageCacheHelper {
  Future<void> cachedLanguageCode(String language) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("LOCALE", language);
  }

  Future<String> getCachedLanguageCode() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final cachedLanguageCode = sharedPreferences.getString("LOCALE");
    if (cachedLanguageCode != null) {
      return cachedLanguageCode;
    }
    return 'en';
  }
}
