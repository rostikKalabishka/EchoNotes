import 'package:note_app/repository/model/model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class AbstractNotesDataBase {
  Future<Database> get database;

  Future<Note> createNotes(Note note);
  Future<Note> readNote(int id);
  Future<List<Note>> readAllNotes();
  Future<int> updateNote(Note note);
  Future<int> deleteNote(Note note);

  Future<TodoList> createTodoList(TodoList todoList);
  Future<List<TodoList>> readAllTodoList();
  Future<int> updateTodoList(TodoList todoList);
  Future<int> deleteTodoList(TodoList todoList);

  Future<Todo> createTodo(Todo todo);
  Future<List<Todo>> readAllTodo();
  Future<int> updateTodo(Todo todo);
  Future<int> deleteTodo(Todo todo);

  Future close();
}
