part of 'add_list_notes_bloc.dart';

class AddListTodoState extends Equatable {
  const AddListTodoState(
      {this.todoListName = 'Todo', this.error = '', this.todo = const []});
  final String todoListName;
  final Object error;
  final List<Todo> todo;

  @override
  List<Object> get props => [todoListName, error, todo];

  AddListTodoState copyWith({
    String? todoListName,
    Object? error,
    List<Todo>? todo,
  }) {
    return AddListTodoState(
      todoListName: todoListName ?? this.todoListName,
      error: error ?? this.error,
      todo: todo ?? this.todo,
    );
  }
}
