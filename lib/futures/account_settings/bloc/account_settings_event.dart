part of 'account_settings_bloc.dart';

sealed class AccountSettingsEvent extends Equatable {
  const AccountSettingsEvent();

  @override
  List<Object> get props => [];
}

class SwitchThemeOnEvent extends AccountSettingsEvent {
  // final bool switchTheme;

  // const SwitchThemeOnEvent({required this.switchTheme});

  // @override
  // List<Object> get props => super.props..addAll([switchTheme]);
}

class SwitchThemeOffEvent extends AccountSettingsEvent {
  // final bool switchTheme;

  // const SwitchThemeOffEvent({required this.switchTheme});

  // @override
  // List<Object> get props => super.props..addAll([switchTheme]);
}

class LoadInfoEvent extends AccountSettingsEvent {
  final BuildContext context;

  const LoadInfoEvent({required this.context});

  @override
  List<Object> get props => super.props..addAll([context]);
}
