import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/repository/model/model.dart';
import 'package:note_app/router/router.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(const NotesState()) {
    on<NotesEvent>((event, emit) async {
      if (event is LoadNotesEvent) {
        await _loadNotes(event, emit);
      } else if (event is OpenAddPage) {
        _navigateToAddNotes(event, emit);
      } else if (event is OpenNotesEvent) {
        _navigateToNotePage(event, emit);
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
                voiceNote: '',
                isImportant: false,
                id: index,
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

  void _navigateToAddNotes(OpenAddPage event, Emitter<NotesState> emit) {
    final autoRouter = AutoRouter.of(event.context);
    autoRouter.push(AddNotesRoute());
  }

  void _navigateToNotePage(OpenNotesEvent event, Emitter<NotesState> emit) {
    try {
      final autoRouter = AutoRouter.of(event.context);
      autoRouter.push(NoteRoute(note: event.note));
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }
}
