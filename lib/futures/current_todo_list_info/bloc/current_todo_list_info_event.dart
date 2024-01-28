part of 'current_todo_list_info_bloc.dart';

sealed class CurrentTodoListInfoEvent extends Equatable {
  const CurrentTodoListInfoEvent();

  @override
  List<Object> get props => [];
}

class LoadTodoListEvent extends CurrentTodoListInfoEvent {
  final TodoList todoList;

  const LoadTodoListEvent({required this.todoList});

  @override
  List<Object> get props => super.props..addAll([todoList]);
}
