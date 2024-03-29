import 'package:note_app/repository/db_repository/abstract_notes_database.dart';
import 'package:note_app/repository/model/note.dart';
import 'package:note_app/repository/model/todo.dart';
import 'package:note_app/repository/model/todo_list.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabase implements AbstractNotesDataBase {
  static final NotesDatabase instance = NotesDatabase._init();
  Database? _database;
  NotesDatabase._init();
  NotesDatabase();
  @override
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const String textType = 'TEXT NOT NULL';
    const String boolType = 'BOOLEAN NOT NULL';
    const String integerType = 'INTEGER NOT NULL';

    await db.execute('''CREATE TABLE $tableNotes(
      ${NoteFields.id} $idType,
      ${NoteFields.name} $textType,
      ${NoteFields.createDate} $textType,
      ${NoteFields.description} $textType,
      ${NoteFields.isDone} $boolType,
      ${NoteFields.isImportant} $boolType,
      ${NoteFields.voiceNote} $textType,
      ${NoteFields.imageUrl} $textType,
      ${NoteFields.createAt} $textType,
      ${NoteFields.protected} $boolType
    )''');

    await db.execute('''CREATE TABLE $tableTodoList(
  ${TodoListFields.id} $idType,
  ${TodoListFields.createDate} $textType,
  ${TodoListFields.percentage} $textType,
  ${TodoListFields.name} $textType,
  ${TodoListFields.createAt} $textType,
  ${TodoListFields.protected} $boolType
)''');

    await db.execute('''CREATE TABLE $tableTodo(
  ${TodoFields.id} $idType,
  ${TodoFields.name} $textType,
  ${TodoFields.createDate} $textType,
  ${TodoFields.isDone} $boolType,
  ${TodoFields.listNoteId} $integerType,
  ${TodoFields.createAt} $textType,
  FOREIGN KEY (${TodoFields.listNoteId}) REFERENCES $tableTodoList(${TodoListFields.id})
)''');
  }

  @override
  Future<Note> readNote(int id) async {
    const List<String> columns = NoteFields.values;
    const String where = '${NoteFields.id} = ?';
    final List<Object?> whereArgs = [id];
    final maps = await read(
        id: id,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        tableName: tableNotes);
    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Map<String, Object?>>> read(
      {required int id,
      List<String>? columns,
      required String tableName,
      String? where,
      List<Object?>? whereArgs}) async {
    final db = await instance.database;
    return await db.query(tableName,
        columns: columns, where: where, whereArgs: whereArgs);
  }

  @override
  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;
    const String orderBy = '${NoteFields.createAt} DESC';
    final result = await db.query(tableNotes, orderBy: orderBy);

    return result.map((json) => Note.fromJson(json)).toList();
  }

  @override
  Future<int> updateNote(Note note) async {
    final db = await instance.database;
    return db.update(tableNotes, note.toJson(),
        where: '${NoteFields.id} = ?', whereArgs: [note.id]);
  }

  @override
  Future<int> deleteNote(Note note) async {
    final db = await instance.database;
    return db.delete(tableNotes,
        where: '${NoteFields.id} = ?', whereArgs: [note.id]);
  }

  @override
  Future<Note> createNotes(Note note) async {
    final db = await instance.database;
    final id = await db.insert(tableNotes, note.toJson());
    return note.copyWith(id: id);
  }

  @override
  Future close() async {
    final db = await instance.database;

    db.close();
  }

  @override
  Future<int> deleteTodoList(TodoList todoList) async {
    final db = await instance.database;
    await db.delete(
      tableTodo,
      where: '${TodoFields.listNoteId} = ?',
      whereArgs: [todoList.id],
    );

    return db.delete(
      tableTodoList,
      where: '${TodoListFields.id} = ?',
      whereArgs: [todoList.id],
    );
  }

  @override
  Future<List<TodoList>> readAllTodoList() async {
    final db = await instance.database;
    const String orderBy = '${TodoListFields.createAt} DESC';
    final result = await db.query(tableTodoList, orderBy: orderBy);

    return result.map((json) => TodoList.fromJson(json)).toList();
  }

  @override
  Future<TodoList> readTodoList(int id) async {
    const List<String> columns = TodoListFields.values;
    const String where = '${TodoListFields.id} = ?';
    final List<Object?> whereArgs = [id];
    final maps = await read(
        id: id,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        tableName: tableTodoList);
    if (maps.isNotEmpty) {
      return TodoList.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  @override
  Future<int> updateTodoList(TodoList todoList) async {
    final db = await instance.database;
    return db.update(tableTodoList, todoList.toJson(),
        where: '${TodoListFields.id} = ?', whereArgs: [todoList.id]);
  }

  @override
  Future<TodoList> createTodoList(TodoList todoList) async {
    final db = await instance.database;
    final id = await db.insert(tableTodoList, todoList.toJson());
    return todoList.copyWith(id: id);
  }

  @override
  Future<Todo> createTodo(Todo todo) async {
    final db = await instance.database;
    final id = await db.insert(tableTodo, todo.toJson());
    return todo.copyWith(id: id);
  }

  @override
  Future<int> deleteTodo(Todo todo) async {
    final db = await instance.database;
    return db.delete(
      tableTodo,
      where: '${TodoFields.id} = ? AND ${TodoFields.listNoteId} = ?',
      whereArgs: [todo.id, todo.listNoteId],
    );
  }

  @override
  Future<List<Todo>> readAllTodo(int listNoteId) async {
    final db = await instance.database;
    const String orderBy = '${TodoFields.createAt} DESC';
    const String where = '${TodoFields.listNoteId} = ?';
    final List<int> whereArgs = [listNoteId];
    final result = await db.query(tableTodo,
        orderBy: orderBy, where: where, whereArgs: whereArgs);

    return result.map((json) => Todo.fromJson(json)).toList();
  }

  @override
  Future<int> updateTodo(Todo todo) async {
    final db = await instance.database;
    return db.update(tableTodo, todo.toJson(),
        where: '${TodoFields.id} = ?', whereArgs: [todo.id]);
  }

  @override
  Future<Todo> readTodo(int id) async {
    const List<String> columns = TodoFields.values;
    const String where = '${TodoFields.id} = ?';
    final List<Object?> whereArgs = [id];
    final maps = await read(
        id: id,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        tableName: tableTodo);
    if (maps.isNotEmpty) {
      return Todo.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }
}
