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
      } else if (event is LoadDefaultValue) {
        _loadDefaultValue(event, emit);
      } else if (event is CheckboxTodoEvent) {
        checkBox(event, emit);
      } else if (event is SaveNameTodoListEvent) {
        _saveNameTodoList(event, emit);
      }
    });
  }

  void _loadDefaultValue(
      LoadDefaultValue event, Emitter<AddListTodoState> emit) {
    emit(state.copyWith(todo: [], todoListName: 'Todo', error: ''));
  }

  void checkBox(CheckboxTodoEvent event, Emitter<AddListTodoState> emit) async {
    try {
      List<Todo> updatedTodoList = List.from(state.todo);
      Todo updatedTodo = event.todo.copyWith(isDone: event.value);
      updatedTodoList[event.todoIndex] = updatedTodo;

      emit(state.copyWith(todo: updatedTodoList));
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  void _saveNameTodoList(
      SaveNameTodoListEvent event, Emitter<AddListTodoState> emit) async {
    try {
      emit(state.copyWith(todoListName: event.name));
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _createTodo(
      CreateTodoEvent event, Emitter<AddListTodoState> emit) async {
    try {
      final todo = Todo(
          isDone: false,
          name: event.name,
          listNoteId: null,
          createDate: DateTime.now().toString(),
          createAt: DateTime.now());

      final updatedList = [...state.todo, todo];

      emit(state.copyWith(todo: updatedList));
      AutoRouter.of(event.context).pop();
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _createTodoList(
    CreateTodoListEvent event,
    Emitter<AddListTodoState> emit,
  ) async {
    final autoRouter = AutoRouter.of(event.context);
    try {
      final createDate = DateFormat('dd.MM.yyyy').format(DateTime.now());
      int count = 0;

      for (var e in state.todo) {
        if (e.isDone == true) {
          count++;
        }
      }
      String percentage;
      if (state.todo.isNotEmpty) {
        percentage = ((count / state.todo.length) * 100).toStringAsFixed(0);
      } else {
        percentage = 0.toString();
      }

      final todoList = TodoList(
        percentage: percentage,
        name: event.name,
        createDate: createDate,
        createAt: DateTime.now(),
      );
      final createdTodoList =
          await abstractNotesDataBase.createTodoList(todoList);

      final List<Todo> existingTodos = state.todo;
      final updatedTodos = <Todo>[];

      for (final todo in existingTodos) {
        final todoWithListId = todo.copyWith(listNoteId: createdTodoList.id);
        final createdTodo =
            await abstractNotesDataBase.createTodo(todoWithListId);
        updatedTodos.add(createdTodo);
      }

      autoRouter.pushAndPopUntil(const ListTodoRoute(),
          predicate: (route) => false);
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }
}
