part of 'list_todo_bloc.dart';

class ListTodoState extends Equatable {
  const ListTodoState(
      {this.error = '',
      this.todoList = const [],
      this.isLoading = false,
      this.currentTheme = false});

  final Object error;
  final List<TodoList> todoList;
  final bool isLoading;
  final bool currentTheme;

  @override
  List<Object> get props => [error, todoList, isLoading, currentTheme];

  ListTodoState copyWith({
    Object? error,
    List<TodoList>? todoList,
    bool? isLoading,
    bool? currentTheme,
  }) {
    return ListTodoState(
        error: error ?? this.error,
        todoList: todoList ?? this.todoList,
        isLoading: isLoading ?? this.isLoading,
        currentTheme: currentTheme ?? this.currentTheme);
  }
}
