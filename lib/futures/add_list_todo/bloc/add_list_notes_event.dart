part of 'add_list_notes_bloc.dart';

sealed class AddListTodoEvent extends Equatable {
  const AddListTodoEvent();

  @override
  List<Object> get props => [];
}

class LoadDefaultValue extends AddListTodoEvent {}

class CreateTodoEvent extends AddListTodoEvent {
  final String name;
  final BuildContext context;

  const CreateTodoEvent({
    required this.name,
    required this.context,
  });
  @override
  List<Object> get props => super.props..addAll([name]);
}

class ExitPageEvent extends AddListTodoEvent {
  const ExitPageEvent();
}

class CheckboxTodoEvent extends AddListTodoEvent {
  final bool value;
  final Todo todo;
  final int todoIndex;

  const CheckboxTodoEvent(
      {required this.value, required this.todo, required this.todoIndex});

  @override
  List<Object> get props => super.props..addAll([value, todo]);
}

class SaveNameTodoListEvent extends AddListTodoEvent {
  final String name;

  const SaveNameTodoListEvent({
    required this.name,
  });
  @override
  List<Object> get props => super.props
    ..addAll([
      name,
    ]);
}

class CreateTodoListEvent extends AddListTodoEvent {
  final String name;
  final BuildContext context;
  const CreateTodoListEvent({
    required this.name,
    required this.context,
  });
  @override
  List<Object> get props => super.props..addAll([name, context]);
}
