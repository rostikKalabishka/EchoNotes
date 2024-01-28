import 'package:equatable/equatable.dart';

const String tableTodoList = 'todo_list';

class TodoListFields {
  static const List<String> values = [
    id,
    name,
    createDate,
    percentage,
  ];

  static const String id = '_id';
  // static const String listTodo = 'listTodo';
  static const String name = 'name';
  static const String percentage = 'percentage';
  static const String createDate = 'createDate';
}

class TodoList extends Equatable {
  final int? id;
  // final List<Todo> listTodo;
  final int percentage;
  final String name;
  final String createDate;

  const TodoList({
    this.id,
    // required this.listTodo,
    required this.percentage,
    required this.name,
    required this.createDate,
  });

  @override
  List<Object?> get props => [
        id,
//listTodo,
        percentage, name, createDate
      ];

  factory TodoList.fromJson(Map<String, Object?> json) {
    // final listTodoJson = json[TodoListFields.listTodo] as List<dynamic>? ?? [];
    // final listTodo = listTodoJson
    //     .map((e) => Todo.fromJson(e as Map<String, dynamic>))
    //     .toList();

    return TodoList(
      id: json[TodoListFields.id] as int?,
      name: json[TodoListFields.name] as String,
      createDate: json[TodoListFields.createDate] as String,
      // listTodo: listTodo,
      percentage: json[TodoListFields.percentage] as int,
    );
  }

  Map<String, Object?> toJson() => {
        TodoListFields.id: id,
        TodoListFields.createDate: createDate,
        TodoListFields.name: name,
        //   TodoListFields.listTodo: listTodo.map((e) => e.toJson()).toList(),
        TodoListFields.percentage: percentage,
      };

  TodoList copyWith({
    int? id,
    // List<Todo>? listTodo,
    int? percentage,
    String? name,
    String? createDate,
  }) {
    return TodoList(
      id: id ?? this.id,
      // listTodo: listTodo ?? this.listTodo,
      percentage: percentage ?? this.percentage,
      name: name ?? this.name,
      createDate: createDate ?? this.createDate,
    );
  }
}
