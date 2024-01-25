import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_list_notes_event.dart';
part 'add_list_notes_state.dart';

class AddListNotesBloc extends Bloc<AddListNotesEvent, AddListNotesState> {
  AddListNotesBloc() : super(AddListNotesInitial()) {
    on<AddListNotesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
