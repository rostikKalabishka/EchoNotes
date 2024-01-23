import 'package:equatable/equatable.dart';
import 'package:note_app/repository/model/note.dart';

class ListNotesFields {
  static const List<String> values = [
    id,
    name,
    listNote,
    createDate,
    percentage
  ];

  static const String id = '_id';
  static const String listNote = 'listNote';
  static const String name = 'name';
  static const String percentage = 'percentage';

  static const String createDate = 'createDate';
}

class ListNotes extends Equatable {
  final int? id;
  final List<Note> listNote;
  final int percentage;
  final String name;
  final String createDate;

  const ListNotes(
      {this.id,
      required this.listNote,
      required this.percentage,
      required this.name,
      required this.createDate});

  @override
  List<Object?> get props => [id, listNote, percentage, name, createDate];

  factory ListNotes.fromJson(Map<String, Object?> json) => ListNotes(
        id: json[ListNotesFields.id] as int?,
        name: json[ListNotesFields.name] as String,
        createDate: json[ListNotesFields.createDate] as String,
        listNote: [], //tut
        percentage: json[ListNotesFields.percentage] as int,
      );

  Map<String, Object?> toJson() => {
        ListNotesFields.id: id,
        ListNotesFields.createDate: createDate,
        ListNotesFields.name: name,
        ListNotesFields.listNote: listNote,
        ListNotesFields.percentage: percentage
      };
}
