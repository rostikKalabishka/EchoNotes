import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_default_note_event.dart';
part 'add_default_note_state.dart';

class AddDefaultNoteBloc
    extends Bloc<AddDefaultNoteEvent, AddDefaultNoteState> {
  AddDefaultNoteBloc() : super(const AddDefaultNoteState()) {
    on<AddDefaultNoteEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
