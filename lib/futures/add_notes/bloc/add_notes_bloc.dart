import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:note_app/core/router/router.dart';

part 'add_notes_event.dart';
part 'add_notes_state.dart';

class AddNotesPageBloc extends Bloc<AddNotesEvent, AddNotesState> {
  AddNotesPageBloc() : super(AddNotesInitial()) {
    on<AddNotesEvent>((event, emit) {
      if (event is NavigateToAddVoiceNotePage) {
        AutoRouter.of(event.context).push(const AddVoiceNoteRoute());
      } else if (event is NavigateToAddNotePage) {
        AutoRouter.of(event.context).push(const AddDefaultNotesRoute());
      }
    });
  }
}
