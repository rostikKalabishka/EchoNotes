import 'package:equatable/equatable.dart';

const String tableTodo = 'todo';

class TodoFields {
  static const List<String> values = [id, name, isDone, listNoteId, createDate];

  static const String id = '_id';
  static const String isDone = 'isDone';
  static const String name = 'name';
  static const String createDate = 'createDate';
  static const String listNoteId = '_list_id';
}

class Todo extends Equatable {
  final int? id;
  final int listNoteId;
  final bool isDone;
  final String name;
  final String createDate;

  const Todo(
      {this.id,
      required this.isDone,
      required this.name,
      required this.listNoteId,
      required this.createDate});

  @override
  List<Object?> get props => [id, isDone, name, createDate, listNoteId];

  factory Todo.fromJson(Map<String, Object?> json) => Todo(
      id: json[TodoFields.id] as int?,
      name: json[TodoFields.name] as String,
      createDate: json[TodoFields.createDate] as String,
      isDone: json[TodoFields.isDone] == 0,
      listNoteId: json[TodoFields.listNoteId] as int);

  Map<String, Object?> toJson() => {
        TodoFields.id: id,
        TodoFields.createDate: createDate,
        TodoFields.name: name,
        TodoFields.isDone: isDone ? 0 : 1,
        TodoFields.listNoteId: listNoteId
      };

  Todo copyWith({
    int? id,
    int? listNoteId,
    bool? isDone,
    String? name,
    String? createDate,
  }) {
    return Todo(
      id: id ?? this.id,
      listNoteId: listNoteId ?? this.listNoteId,
      isDone: isDone ?? this.isDone,
      name: name ?? this.name,
      createDate: createDate ?? this.createDate,
    );
  }
}
