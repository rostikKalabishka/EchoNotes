import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_notes_event.dart';
part 'add_notes_state.dart';

class AddNotesPageBloc extends Bloc<AddNotesEvent, AddNotesState> {
  AddNotesPageBloc() : super(AddNotesInitial()) {
    on<AddNotesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
