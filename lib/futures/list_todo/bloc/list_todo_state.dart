// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'list_todo_bloc.dart';

class ListTodoState extends Equatable {
  const ListTodoState(
      {this.error = '', this.todoList = const [], this.isLoading = false});

  final Object error;
  final List<TodoList> todoList;
  final bool isLoading;

  @override
  List<Object> get props => [error, todoList, isLoading];

  ListTodoState copyWith({
    Object? error,
    List<TodoList>? todoList,
    bool? isLoading,
  }) {
    return ListTodoState(
      error: error ?? this.error,
      todoList: todoList ?? this.todoList,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
