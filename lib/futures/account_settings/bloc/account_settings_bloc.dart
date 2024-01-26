import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note_app/repository/db_repository/abstract_notes_database.dart';

part 'account_settings_event.dart';
part 'account_settings_state.dart';

class AccountSettingsBloc
    extends Bloc<AccountSettingsEvent, AccountSettingsState> {
  final AbstractNotesDataBase abstractNotesDataBase;
  AccountSettingsBloc(this.abstractNotesDataBase)
      : super(AccountSettingsInitial()) {
    on<AccountSettingsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
