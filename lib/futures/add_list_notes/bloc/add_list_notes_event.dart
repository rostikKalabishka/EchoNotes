part of 'add_list_notes_bloc.dart';

sealed class AddListNotesEvent extends Equatable {
  const AddListNotesEvent();

  @override
  List<Object> get props => [];
}

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
