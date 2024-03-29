import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/core/router/router.dart';
import 'package:note_app/repository/db_repository/abstract_notes_database.dart';
import 'package:note_app/repository/model/note.dart';

part 'add_default_note_event.dart';
part 'add_default_note_state.dart';

class AddDefaultNoteBloc
    extends Bloc<AddDefaultNoteEvent, AddDefaultNoteState> {
  final AbstractNotesDataBase abstractNotesDataBase;
  AddDefaultNoteBloc(this.abstractNotesDataBase)
      : super(const AddDefaultNoteState()) {
    on<AddDefaultNoteEvent>((event, emit) async {
      if (event is AddDefaultNote) {
        await _addNote(event, emit);
      }
    });
  }

  Future<void> _addNote(
      AddDefaultNote event, Emitter<AddDefaultNoteState> emit) async {
    final _autoRoute = AutoRouter.of(event.context);
    try {
      final createDate = DateFormat('dd.MM.yyyy').format(DateTime.now());

      final note = Note(
          createAt: DateTime.now(),
          name: event.noteName,
          voiceNote: '',
          description: event.description,
          createDate: createDate,
          imageUrl: '',
          isImportant: false,
          isDone: false,
          protected: false);

      await abstractNotesDataBase.createNotes(note);
      emit(state);

      _autoRoute.pushAndPopUntil(const NotesRoute(),
          predicate: (route) => false);
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(error: e));
    }
  }
}
