import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'note_page_event.dart';
part 'note_page_state.dart';

class NotePageBloc extends Bloc<NotePageEvent, NotePageState> {
  NotePageBloc() : super(NotePageInitial()) {
    on<NotePageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
