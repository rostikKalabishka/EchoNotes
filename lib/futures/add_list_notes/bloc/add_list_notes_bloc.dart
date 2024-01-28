import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:note_app/repository/db_repository/abstract_notes_database.dart';
import 'package:note_app/repository/model/todo.dart';
import 'package:note_app/repository/model/todo_list.dart';
import 'package:note_app/router/router.dart';

part 'add_list_notes_event.dart';
part 'add_list_notes_state.dart';

class AddListNotesBloc extends Bloc<AddListNotesEvent, AddListTodoState> {
  final AbstractNotesDataBase abstractNotesDataBase;
  AddListNotesBloc(this.abstractNotesDataBase)
      : super(const AddListTodoState()) {
    on<AddListNotesEvent>((event, emit) async {
      if (event is CreateTodoEvent) {
        await _createTodo(event, emit);
      } else if (event is CreateTodoListEvent) {
        await _createTodoList(event, emit);
      }
    });
  }

  Future<void> _createTodo(
      CreateTodoEvent event, Emitter<AddListTodoState> emit) async {
    try {
      final todo = Todo(
          isDone: false,
          name: event.name,
          listNoteId: null,
          createDate: DateTime.now().toString());

      final updatedList = [...state.todo, todo];

      emit(state.copyWith(todo: updatedList));
      AutoRouter.of(event.context).pop();
    } catch (e) {
      log('$e');
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _createTodoList(
      CreateTodoListEvent event, Emitter<AddListTodoState> emit) async {
    final autoRouter = AutoRouter.of(event.context);
    try {
      final createDate = DateFormat('dd.MM.yyyy').format(DateTime.now());
      final todoList = TodoList(
        percentage: 0,
        name: event.name,
        createDate: createDate,
      );
      final createdTodoList =
          await abstractNotesDataBase.createTodoList(todoList);
      final List<Todo> existingTodos = state.todo;

      final updatedTodos = existingTodos.map((todo) {
        return todo.copyWith(listNoteId: createdTodoList.id);
      }).toList();

      emit(state.copyWith(todo: updatedTodos));

      autoRouter.pushAndPopUntil(const ListTodoRoute(),
          predicate: (route) => false);
    } catch (e) {
      log('$e');
      emit(state.copyWith(error: e));
    }
  }
}
