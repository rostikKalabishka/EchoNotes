part of 'current_todo_list_info_bloc.dart';

class CurrentTodoListInfoState extends Equatable {
  final List<Todo> todo;
  final String name;
  final bool protected;

  final Object error;
  final bool isLoading;
  const CurrentTodoListInfoState(
      {this.todo = const [],
      this.protected = false,
      this.name = '',
      this.error = '',
      this.isLoading = false});

  @override
  List<Object> get props => [todo, name, error, isLoading, protected];

  CurrentTodoListInfoState copyWith({
    List<Todo>? todo,
    String? name,
    Object? error,
    bool? isLoading,
    bool? protected,
  }) {
    return CurrentTodoListInfoState(
      todo: todo ?? this.todo,
      name: name ?? this.name,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      protected: protected ?? this.protected,
    );
  }
}
