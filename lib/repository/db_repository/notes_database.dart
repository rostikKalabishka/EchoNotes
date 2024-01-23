import 'package:note_app/repository/db_repository/abstract_notes_database.dart';
import 'package:note_app/repository/model/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabase implements AbstractNotesDataBase {
  static final NotesDatabase instance = NotesDatabase._init();
  Database? _database;
  NotesDatabase._init();

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
    // const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    // const String textType = 'TEXT NOT NULL';
    // const String boolType = 'BOOLEAN NOT NULL';
    // const String integerType = 'INTEGER NOT NULL';

    await db.execute('''CREATE TABLE $tableNotes()''');
  }

  // @override
  // Future<Note> create(Note note) async{
  //   // final db = await instance.database;
  //   // final id = await db.insert(tableNotes, note.toJson());
  //   // return note.copyWith(id: id);

  // }
}
