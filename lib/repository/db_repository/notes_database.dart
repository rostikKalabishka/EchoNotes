import 'package:note_app/repository/db_repository/abstract_notes_database.dart';
import 'package:note_app/repository/model/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabase implements AbstractNotesDataBase {
  static final NotesDatabase instance = NotesDatabase._init();
  Database? _database;
  NotesDatabase._init();

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
    // const String integerType = 'INTEGER NOT NULL';

    await db.execute('''CREATE TABLE $tableNotes(
      ${NoteFields.id} $idType,
      ${NoteFields.name} $textType,
      ${NoteFields.createDate} $textType,
      ${NoteFields.description} $textType,
      ${NoteFields.isDone} $boolType,
      ${NoteFields.isImportant} $boolType,
       ${NoteFields.voiceNote} $textType
    )''');
  }

  @override
  Future<Note> readNote(int id) async {
    final db = await instance.database;
    final maps = await db.query(tableNotes,
        columns: NoteFields.values,
        where: '${NoteFields.id} = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  @override
  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;
    const String orderBy = '${NoteFields.createDate} ASC';
    final result = await db.query(tableNotes, orderBy: orderBy);

    return result.map((json) => Note.fromJson(json)).toList();
  }

  @override
  Future<int> update(Note note) async {
    final db = await instance.database;
    return db.update(tableNotes, note.toJson(),
        where: '${NoteFields.id} = ?', whereArgs: [note.id]);
  }

  @override
  Future<int> delete(Note note) async {
    final db = await instance.database;
    return db.delete(tableNotes,
        where: '${NoteFields.id} = ?', whereArgs: [note.id]);
  }

  @override
  Future<Note> create(Note note) async {
    final db = await instance.database;
    final id = await db.insert(tableNotes, note.toJson());
    return note.copyWith(id: id);
  }

  @override
  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
