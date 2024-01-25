import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:note_app/router/router.dart';

part 'list_notes_event.dart';
part 'list_notes_state.dart';

class ListNotesBloc extends Bloc<ListNotesEvent, ListNotesState> {
  ListNotesBloc() : super(ListNotesInitial()) {
    on<ListNotesEvent>((event, emit) async {
      if (event is NavigateToAddListNotesEvent) {
        _navigateToAddNotesPage(event, emit);
      }
    });
  }
  void _navigateToAddNotesPage(
      NavigateToAddListNotesEvent event, Emitter<ListNotesState> emit) {
    final autoRouter = AutoRouter.of(event.context);

    autoRouter.push(const AddListNotesRoute());
  }
}
