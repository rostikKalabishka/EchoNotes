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
