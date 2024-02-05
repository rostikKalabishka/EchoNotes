part of 'current_todo_list_info_bloc.dart';

class CurrentTodoListInfoEvent extends Equatable {
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

class ChangeNameCurrentTodoListEvent extends CurrentTodoListInfoEvent {
  final String name;
  final TodoList todoList;

  const ChangeNameCurrentTodoListEvent({
    required this.name,
    required this.todoList,
  });
  @override
  List<Object> get props => super.props..addAll([name, todoList]);
}

class CreateNewTodoEvent extends CurrentTodoListInfoEvent {
  final String name;
  final BuildContext context;
  final int id;
  final TodoList todoList;

  const CreateNewTodoEvent({
    required this.id,
    required this.name,
    required this.context,
    required this.todoList,
  });
  @override
  List<Object> get props => super.props..addAll([name, context, id, todoList]);
}

class CheckboxTodoEvent extends CurrentTodoListInfoEvent {
  final bool value;
  final Todo todo;
  final int todoIndex;
  final TodoList todoList;

  const CheckboxTodoEvent(
      {required this.value,
      required this.todo,
      required this.todoIndex,
      required this.todoList});

  @override
  List<Object> get props =>
      super.props..addAll([value, todo, todoIndex, todoList]);
}

class DeleteCurrentTodoListEvent extends CurrentTodoListInfoEvent {
  final TodoList todo;
  final BuildContext context;

  const DeleteCurrentTodoListEvent({required this.todo, required this.context});
  @override
  List<Object> get props => super.props..addAll([todo, context]);
}

class DeleteTodoEvent extends CurrentTodoListInfoEvent {
  final Todo todo;
  final int index;
  final BuildContext context;
  final TodoList todoList;

  const DeleteTodoEvent(
      {required this.todo,
      required this.context,
      required this.index,
      required this.todoList});
  @override
  List<Object> get props => super.props..addAll([todo, context, index]);
}
