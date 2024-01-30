part of 'list_todo_bloc.dart';

sealed class ListTodoListEvent extends Equatable {
  const ListTodoListEvent();

  @override
  List<Object> get props => [];
}

class LoadTodoListEvent extends ListTodoListEvent {}

class NavigateToAddTodoNotesEvent extends ListTodoListEvent {
  final BuildContext context;

  const NavigateToAddTodoNotesEvent({required this.context});
  @override
  List<Object> get props => super.props..addAll([context]);
}

class NavigateToCurrentTodoInfoListEvent extends ListTodoListEvent {
  final BuildContext context;
  final TodoList todoList;

  const NavigateToCurrentTodoInfoListEvent(
      {required this.context, required this.todoList});
  @override
  List<Object> get props => super.props..addAll([context, todoList]);
}

class ChangeNameCurrentTodoListEvent extends ListTodoListEvent {
  final String name;
  final TodoList todoList;
  final int index;

  const ChangeNameCurrentTodoListEvent({
    required this.name,
    required this.todoList,
    required this.index,
  });
  @override
  List<Object> get props => super.props..addAll([name, todoList, index]);
}

class DeleteTodoListEvent extends ListTodoListEvent {
  final TodoList todoList;
  final BuildContext context;

  const DeleteTodoListEvent({required this.todoList, required this.context});
  @override
  List<Object> get props => super.props..addAll([todoList]);
}
