import 'package:note_app/repository/model/model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class AbstractNotesDataBase {
  Future<Note> create(Note note);
  Future<Database> get database;
  Future<Note> readNote(int id);
  Future<List<Note>> readAllNotes();
  Future<int> update(Note note);
  Future<int> delete(Note note);
  Future close();
}
