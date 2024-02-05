import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:note_app/repository/db_repository/abstract_notes_database.dart';
import 'package:note_app/repository/shared_pref_theme/abstract_shared_pref_theme.dart';

part 'account_settings_event.dart';
part 'account_settings_state.dart';

class AccountSettingsBloc
    extends Bloc<AccountSettingsEvent, AccountSettingsState> {
  final AbstractNotesDataBase abstractNotesDataBase;
  final AbstractSharedPrefTheme abstractSharedPrefTheme;
  AccountSettingsBloc(
    this.abstractNotesDataBase,
    this.abstractSharedPrefTheme,
  ) : super(const AccountSettingsState()) {
    on<AccountSettingsEvent>((event, emit) async {
      if (event is SwitchThemeOnEvent) {
        await _switchOnTheme(event, emit);
      } else if (event is SwitchThemeOffEvent) {
        await _switchOffTheme(event, emit);
      } else if (event is LoadInfoEvent) {
        await _loadInfo(event, emit);
      }
    });
  }

  Future<void> _switchOnTheme(
      SwitchThemeOnEvent event, Emitter<AccountSettingsState> emit) async {
    // final bool? boolSwitch = await abstractSharedPrefTheme.getThemeData();
    try {
      await abstractSharedPrefTheme.setThemeData(switchBool: true);
      final bool? boolSwitch = await abstractSharedPrefTheme.getThemeData();
      emit(state.copyWith(switchBoolTheme: boolSwitch));
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _switchOffTheme(
      SwitchThemeOffEvent event, Emitter<AccountSettingsState> emit) async {
    // final bool? boolSwitch = await abstractSharedPrefTheme.getThemeData();
    try {
      await abstractSharedPrefTheme.setThemeData(switchBool: false);
      final bool? boolSwitch = await abstractSharedPrefTheme.getThemeData();
      emit(state.copyWith(switchBoolTheme: boolSwitch));
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _loadInfo(
      LoadInfoEvent event, Emitter<AccountSettingsState> emit) async {
    try {
      ThemeMode systemTheme =
          MediaQuery.of(event.context).platformBrightness == Brightness.dark
              ? ThemeMode.dark
              : ThemeMode.light;

      if (await abstractSharedPrefTheme.getThemeData() == null) {
        await abstractSharedPrefTheme.setThemeData(
            switchBool: systemTheme == ThemeMode.dark);

        final bool? boolSwitch = await abstractSharedPrefTheme.getThemeData();
        emit(state.copyWith(switchBoolTheme: boolSwitch));
      } else {
        final bool? boolSwitch = await abstractSharedPrefTheme.getThemeData();
        emit(state.copyWith(switchBoolTheme: boolSwitch));
      }
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }
}
