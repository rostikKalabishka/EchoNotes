part of 'account_settings_bloc.dart';

class AccountSettingsState extends Equatable {
  const AccountSettingsState({
    this.themeMode = ThemeMode.system,
    this.switchBoolTheme = false,
    this.error = '',
  });
  final ThemeMode themeMode;
  final Object error;
  final bool switchBoolTheme;
  @override
  List<Object> get props => [themeMode, switchBoolTheme, error];

  AccountSettingsState copyWith({
    ThemeMode? themeMode,
    bool? switchBoolTheme,
    Object? error,
  }) {
    return AccountSettingsState(
      themeMode: themeMode ?? this.themeMode,
      switchBoolTheme: switchBoolTheme ?? this.switchBoolTheme,
      error: error ?? this.error,
    );
  }
}
