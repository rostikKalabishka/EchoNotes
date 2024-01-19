import 'package:note_app/repository/model/note.dart';

class ListNotes {
  final int? id;
  final List<Note> listNote;
  final int percentage;
  final String name;
  final DateTime createDate;

  ListNotes(
      {this.id,
      required this.listNote,
      required this.percentage,
      required this.name,
      required this.createDate});
}
