import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_voice_note_event.dart';
part 'add_voice_note_state.dart';

class AddVoiceNoteBloc extends Bloc<AddVoiceNoteEvent, AddVoiceNoteState> {
  AddVoiceNoteBloc() : super(AddVoiceNoteInitial()) {
    on<AddVoiceNoteEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
