import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:note_app/repository/model/model.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(const NotesState()) {
    on<NotesEvent>((event, emit) async {
      if (event is LoadNotesEvent) {
        await _loadNotes(event, emit);
      }
    }, transformer: sequential());
  }

  Future<void> _loadNotes(NotesEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final createDate = DateFormat('dd.MM.yyyy').format(DateTime.now());
      final List<Note> listNotes = List.generate(
          12,
          (int index) => Note(
                createDate: createDate,
                name: 'Name $index',
                description: 'description $index',
                isDone: false,
              ));

      emit(state.copyWith(isLoading: true, noteList: listNotes));
    } catch (e) {
      emit(state.copyWith(isLoading: true, error: e));
    }
  }
}
