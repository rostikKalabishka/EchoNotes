import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:note_app/core/router/router.dart';
import 'package:note_app/repository/db_repository/abstract_notes_database.dart';
import 'package:note_app/repository/local_auth_repository/abstract_local_auth_repository.dart';
import 'package:note_app/repository/model/todo_list.dart';
import 'package:note_app/repository/shared_pref_theme/abstract_shared_pref_theme.dart';

part 'list_todo_event.dart';
part 'list_todo_state.dart';

class ListTodoBloc extends Bloc<ListTodoListEvent, ListTodoState> {
  final AbstractNotesDataBase abstractNotesDataBase;
  final AbstractSharedPrefTheme abstractSharedPrefTheme;
  final AbstractLocalAuthRepository abstractLocalAuthRepository;
  ListTodoBloc(this.abstractNotesDataBase, this.abstractSharedPrefTheme,
      this.abstractLocalAuthRepository)
      : super(const ListTodoState()) {
    on<ListTodoListEvent>((event, emit) async {
      if (event is NavigateToAddTodoNotesEvent) {
        _navigateToAddNotesPage(event, emit);
      } else if (event is LoadTodoListEvent) {
        await _loadTodoList(event, emit);
      } else if (event is DeleteTodoListEvent) {
        await _deleteTodoList(event, emit);
      } else if (event is NavigateToCurrentTodoInfoListEvent) {
        await _navigateToCurrentTodoListInfoPage(event, emit);
      } else if (event is ChangeNameCurrentTodoListEvent) {
        await _saveNameTodoList(event, emit);
      }
    }, transformer: sequential());
  }
  void _navigateToAddNotesPage(
      NavigateToAddTodoNotesEvent event, Emitter<ListTodoState> emit) {
    final autoRouter = AutoRouter.of(event.context);

    autoRouter.push(const AddListTodoRoute());
  }

  Future<void> _navigateToCurrentTodoListInfoPage(
      NavigateToCurrentTodoInfoListEvent event,
      Emitter<ListTodoState> emit) async {
    try {
      final autoRouter = AutoRouter.of(event.context);
      if (event.todoList.protected == false) {
        autoRouter.push(CurrentTodoListInfoRoute(todoList: event.todoList));
      }

      if (event.todoList.protected == true) {
        if (await abstractLocalAuthRepository.authenticate() == true) {
          autoRouter.push(CurrentTodoListInfoRoute(todoList: event.todoList));
        }
      }
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _loadTodoList(
      LoadTodoListEvent event, Emitter<ListTodoState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final List<TodoList> todoList =
          await abstractNotesDataBase.readAllTodoList();
      final bool? currentTheme = await abstractSharedPrefTheme.getThemeData();
      if (currentTheme != null) {
        emit(state.copyWith(
            isLoading: false, todoList: todoList, currentTheme: currentTheme));
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(isLoading: false, error: e));
    }
  }

  Future<void> _saveNameTodoList(
      ChangeNameCurrentTodoListEvent event, Emitter<ListTodoState> emit) async {
    var newState = state;
    try {
      var updatedTodoList = newState.todoList
          .map((todoList) => todoList.copyWith(
              name: (todoList == newState.todoList[event.index])
                  ? event.name
                  : todoList.name))
          .toList();

      newState = newState.copyWith(todoList: updatedTodoList);

      emit(newState);
      await abstractNotesDataBase
          .updateTodoList(event.todoList.copyWith(name: event.name));
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _deleteTodoList(
      DeleteTodoListEvent event, Emitter<ListTodoState> emit) async {
    final autoRouter = AutoRouter.of(event.context);
    try {
      await abstractNotesDataBase.deleteTodoList(event.todoList);
      emit(state);
      autoRouter.pop();
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }
}
