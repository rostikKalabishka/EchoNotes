import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:note_app/router/router.dart';

part 'add_default_note_event.dart';
part 'add_default_note_state.dart';

class AddDefaultNoteBloc
    extends Bloc<AddDefaultNoteEvent, AddDefaultNoteState> {
  AddDefaultNoteBloc() : super(const AddDefaultNoteState()) {
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
      emit(state.copyWith(
          description: event.description, noteName: event.noteName));
      _autoRoute.pushAndPopUntil(const NotesRoute(),
          predicate: (route) => false);
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }
}
