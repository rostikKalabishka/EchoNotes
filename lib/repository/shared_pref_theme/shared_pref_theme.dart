import 'package:note_app/repository/shared_pref_theme/abstract_shared_pref_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefTheme implements AbstractSharedPrefTheme {
  final SharedPreferences prefs;
  static const themeKey = 'theme_key';
  SharedPrefTheme({required this.prefs});

  @override
  Future<bool?> getThemeData() async {
    return prefs.getBool(themeKey);
  }

  @override
  Future<void> setThemeData({required bool switchBool}) async {
    await prefs.setBool(themeKey, switchBool);
  }
}
