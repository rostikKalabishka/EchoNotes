import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:note_app/repository/db_repository/abstract_notes_database.dart';
import 'package:note_app/repository/model/todo_list.dart';
import 'package:note_app/router/router.dart';

part 'list_todo_event.dart';
part 'list_todo_state.dart';

class ListTodoBloc extends Bloc<ListTodoListEvent, ListTodoState> {
  final AbstractNotesDataBase abstractNotesDataBase;
  ListTodoBloc(this.abstractNotesDataBase) : super(const ListTodoState()) {
    on<ListTodoListEvent>((event, emit) async {
      if (event is NavigateToAddTodoNotesEvent) {
        _navigateToAddNotesPage(event, emit);
      } else if (event is LoadTodoListEvent) {
        await _loadTodoList(event, emit);
      }
    });
  }
  void _navigateToAddNotesPage(
      NavigateToAddTodoNotesEvent event, Emitter<ListTodoState> emit) {
    final autoRouter = AutoRouter.of(event.context);

    autoRouter.push(const AddListNotesRoute());
  }

  Future<void> _loadTodoList(
      LoadTodoListEvent event, Emitter<ListTodoState> emit) async {
    emit(state.copyWith(isLoading: false));
    try {
      final List<TodoList> todoList =
          await abstractNotesDataBase.readAllTodoList();
      emit(state.copyWith(isLoading: false, todoList: todoList));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e));
    }
  }
}
