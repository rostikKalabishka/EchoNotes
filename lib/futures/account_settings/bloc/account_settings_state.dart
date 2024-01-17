part of 'account_settings_bloc.dart';

sealed class AccountSettingsState extends Equatable {
  const AccountSettingsState();
  
  @override
  List<Object> get props => [];
}

final class AccountSettingsInitial extends AccountSettingsState {}
