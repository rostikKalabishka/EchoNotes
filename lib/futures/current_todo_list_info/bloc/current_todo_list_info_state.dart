part of 'current_todo_list_info_bloc.dart';

class CurrentTodoListInfoState extends Equatable {
  final List<Todo> todo;
  final String name;

  final Object error;
  final bool isLoading;
  const CurrentTodoListInfoState(
      {this.todo = const [],
      this.name = '',
      this.error = '',
      this.isLoading = false});

  @override
  List<Object> get props => [todo, name, error, isLoading];

  CurrentTodoListInfoState copyWith({
    List<Todo>? todo,
    String? name,
    Object? error,
    bool? isLoading,
  }) {
    return CurrentTodoListInfoState(
      todo: todo ?? this.todo,
      name: name ?? this.name,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
