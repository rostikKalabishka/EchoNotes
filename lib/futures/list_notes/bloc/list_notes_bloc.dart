import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'list_notes_event.dart';
part 'list_notes_state.dart';

class ListNotesBloc extends Bloc<ListNotesEvent, ListNotesState> {
  ListNotesBloc() : super(ListNotesInitial()) {
    on<ListNotesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
