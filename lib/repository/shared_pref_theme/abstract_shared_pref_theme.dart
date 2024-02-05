abstract interface class AbstractSharedPrefTheme {
  Future<void> setThemeData({required bool switchBool});
  Future<bool?> getThemeData();
}
