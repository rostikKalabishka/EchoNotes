part of 'add_list_notes_bloc.dart';

sealed class AddListNotesEvent extends Equatable {
  const AddListNotesEvent();

  @override
  List<Object> get props => [];
}

class LoadDefaultValue extends AddListNotesEvent {}

class CreateTodoEvent extends AddListNotesEvent {
  final String name;
  final BuildContext context;

  const CreateTodoEvent({
    required this.name,
    required this.context,
  });
  @override
  List<Object> get props => super.props..addAll([name]);
}

class ExitPageEvent extends AddListNotesEvent {
  const ExitPageEvent();
}

class CheckboxTodoEvent extends AddListNotesEvent {
  final bool value;
  final Todo todo;
  final int todoIndex;

  const CheckboxTodoEvent(
      {required this.value, required this.todo, required this.todoIndex});

  @override
  List<Object> get props => super.props..addAll([value, todo]);
}

class CreateTodoListEvent extends AddListNotesEvent {
  final String name;
  final BuildContext context;
  const CreateTodoListEvent({
    required this.name,
    required this.context,
  });
  @override
  List<Object> get props => super.props..addAll([name, context]);
}
