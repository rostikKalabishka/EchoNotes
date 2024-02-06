import 'package:equatable/equatable.dart';

const String tableTodoList = 'todo_list';

class TodoListFields {
  static const List<String> values = [
    id,
    name,
    createDate,
    percentage,
    createAt,
    protected
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String percentage = 'percentage';
  static const String createDate = 'createDate';
  static const String createAt = 'createAt';
  static const String protected = 'protected';
}

class TodoList extends Equatable {
  final int? id;
  final DateTime createAt;
  final String percentage;
  final String name;
  final String createDate;
  final bool protected;

  const TodoList({
    this.id,
    required this.percentage,
    required this.createAt,
    required this.name,
    required this.protected,
    required this.createDate,
  });

  @override
  List<Object?> get props =>
      [id, percentage, name, createDate, createAt, protected];

  factory TodoList.fromJson(Map<String, Object?> json) {
    return TodoList(
        id: json[TodoListFields.id] as int?,
        name: json[TodoListFields.name] as String,
        createDate: json[TodoListFields.createDate] as String,
        percentage: json[TodoListFields.percentage] as String,
        protected: json[TodoListFields.protected] == 0,
        createAt: DateTime.parse(json[TodoListFields.createAt] as String));
  }

  Map<String, Object?> toJson() => {
        TodoListFields.id: id,
        TodoListFields.createDate: createDate,
        TodoListFields.name: name,
        TodoListFields.percentage: percentage,
        TodoListFields.createAt: createAt.toIso8601String(),
        TodoListFields.protected: protected ? 0 : 1
      };

  TodoList copyWith({
    int? id,
    String? percentage,
    String? name,
    String? createDate,
    DateTime? createAt,
    bool? protected,
  }) {
    return TodoList(
        id: id ?? this.id,
        percentage: percentage ?? this.percentage,
        name: name ?? this.name,
        createDate: createDate ?? this.createDate,
        createAt: createAt ?? this.createAt,
        protected: protected ?? this.protected);
  }
}
