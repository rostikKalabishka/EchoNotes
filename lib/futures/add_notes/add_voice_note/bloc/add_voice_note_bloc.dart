import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note_app/repository/db_repository/abstract_notes_database.dart';

part 'add_voice_note_event.dart';
part 'add_voice_note_state.dart';

class AddVoiceNoteBloc extends Bloc<AddVoiceNoteEvent, AddVoiceNoteState> {
  final AbstractNotesDataBase abstractNotesDataBase;
  AddVoiceNoteBloc(this.abstractNotesDataBase) : super(AddVoiceNoteInitial()) {
    on<AddVoiceNoteEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
