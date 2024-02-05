import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:note_app/core/router/router.dart';
import 'package:note_app/repository/db_repository/abstract_notes_database.dart';
import 'package:note_app/repository/model/model.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final AbstractNotesDataBase abstractNotesDataBase;
  NotesBloc(this.abstractNotesDataBase) : super(const NotesState()) {
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

  Future<void> _loadNotes(
      LoadNotesEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final List<Note> listNotes = await abstractNotesDataBase.readAllNotes();

      emit(state.copyWith(isLoading: false, noteList: listNotes));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e));
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
