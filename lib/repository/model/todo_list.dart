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
  static const String name = 'name';
  static const String percentage = 'percentage';
  static const String createDate = 'createDate';
}

class TodoList extends Equatable {
  final int? id;

  final String percentage;
  final String name;
  final String createDate;

  const TodoList({
    this.id,
    required this.percentage,
    required this.name,
    required this.createDate,
  });

  @override
  List<Object?> get props => [id, percentage, name, createDate];

  factory TodoList.fromJson(Map<String, Object?> json) {
    return TodoList(
      id: json[TodoListFields.id] as int?,
      name: json[TodoListFields.name] as String,
      createDate: json[TodoListFields.createDate] as String,
      percentage: json[TodoListFields.percentage] as String,
    );
  }

  Map<String, Object?> toJson() => {
        TodoListFields.id: id,
        TodoListFields.createDate: createDate,
        TodoListFields.name: name,
        TodoListFields.percentage: percentage,
      };

  TodoList copyWith({
    int? id,
    String? percentage,
    String? name,
    String? createDate,
  }) {
    return TodoList(
      id: id ?? this.id,
      percentage: percentage ?? this.percentage,
      name: name ?? this.name,
      createDate: createDate ?? this.createDate,
    );
  }
}
