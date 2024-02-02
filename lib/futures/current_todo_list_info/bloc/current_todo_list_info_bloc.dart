import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:note_app/repository/db_repository/abstract_notes_database.dart';
import 'package:note_app/repository/model/todo.dart';
import 'package:note_app/repository/model/todo_list.dart';
import 'package:note_app/router/router.dart';

part 'current_todo_list_info_event.dart';
part 'current_todo_list_info_state.dart';

class CurrentTodoListInfoBloc
    extends Bloc<CurrentTodoListInfoEvent, CurrentTodoListInfoState> {
  final AbstractNotesDataBase abstractNotesDataBase;
  CurrentTodoListInfoBloc(this.abstractNotesDataBase)
      : super(const CurrentTodoListInfoState()) {
    on<CurrentTodoListInfoEvent>((event, emit) async {
      if (event is LoadTodoListEvent) {
        await _loadTodoList(event, emit);
      } else if (event is DeleteCurrentTodoListEvent) {
        await _deleteNote(event, emit);
      } else if (event is ChangeNameCurrentTodoListEvent) {
        await _saveNameTodoList(event, emit);
      } else if (event is CheckboxTodoEvent) {
        await _checkBox(event, emit);
      } else if (event is CreateNewTodoEvent) {
        await _createTodo(event, emit);
      }
    }, transformer: sequential());
  }

  Future<void> _createTodo(
      CreateNewTodoEvent event, Emitter<CurrentTodoListInfoState> emit) async {
    final autoRouter = AutoRouter.of(event.context);
    try {
      final todo = Todo(
          isDone: false,
          name: event.name,
          listNoteId: event.id,
          createDate: DateTime.now().toString(),
          createAt: DateTime.now());

      final insertedTodoId = await abstractNotesDataBase.createTodo(todo);

      final updatedTodo = todo.copyWith(id: insertedTodoId.id);

      final updatedList = [...state.todo, updatedTodo];

      emit(state.copyWith(todo: updatedList));

      int doneCount = updatedList.where((todo) => todo.isDone).length;
      double percentage = (doneCount / updatedList.length) * 100;

      await abstractNotesDataBase.updateTodoList(
          event.todoList.copyWith(percentage: percentage.toStringAsFixed(0)));

      autoRouter.pop();
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _checkBox(
      CheckboxTodoEvent event, Emitter<CurrentTodoListInfoState> emit) async {
    try {
      List<Todo> updatedTodoList = List.from(state.todo);

      // Ensure that the Todo and its properties are not null
      if (event.todo.id != null && event.todo.listNoteId != null) {
        Todo updatedTodo = event.todo.copyWith(isDone: event.value);
        updatedTodoList[event.todoIndex] = updatedTodo;

        await abstractNotesDataBase.updateTodo(updatedTodo);
        emit(state.copyWith(todo: updatedTodoList));

        int doneCount = updatedTodoList.where((todo) => todo.isDone).length;
        double percentage = (doneCount / updatedTodoList.length) * 100;

        await abstractNotesDataBase.updateTodoList(
          event.todoList.copyWith(percentage: percentage.toStringAsFixed(0)),
        );
      } else {
        emit(state.copyWith(error: 'Todo or its properties are null.'));
      }
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _saveNameTodoList(ChangeNameCurrentTodoListEvent event,
      Emitter<CurrentTodoListInfoState> emit) async {
    try {
      emit(state.copyWith(name: event.name));
      await abstractNotesDataBase
          .updateTodoList(event.todoList.copyWith(name: event.name));
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _loadTodoList(
      LoadTodoListEvent event, Emitter<CurrentTodoListInfoState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final todoList =
          await abstractNotesDataBase.readTodoList(event.todoList.id!);
      final List<Todo> todo =
          await abstractNotesDataBase.readAllTodo(event.todoList.id!);
      emit(state.copyWith(isLoading: false, todo: todo, name: todoList.name));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e));
    }
  }

  Future<void> _deleteNote(DeleteCurrentTodoListEvent event,
      Emitter<CurrentTodoListInfoState> emit) async {
    final autoRouter = AutoRouter.of(event.context);

    try {
      await abstractNotesDataBase.deleteTodoList(event.todo);
      autoRouter.pushAndPopUntil(const ListTodoRoute(),
          predicate: (route) => false);
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }
}
