import 'package:equatable/equatable.dart';

const String tableNotes = 'notes';

class NoteFields {
  static const List<String> values = [
    id,
    isImportant,
    name,
    description,
    imageUrl,
    isDone,
    createDate,
    voiceNote,
    createAt,
    protected
  ];

  static const String id = '_id';
  static const String isImportant = 'isImportant';
  static const String name = 'name';
  static const String description = 'description';
  static const String isDone = 'isDone';
  static const String createDate = 'createDate';
  static const String imageUrl = 'imageUrl';
  static const String voiceNote = 'voiceNote';
  static const String createAt = 'createAt';
  static const String protected = 'protected';
}

class Note extends Equatable {
  final int? id;
  final String name;
  final String description;
  final String createDate;
  final String imageUrl;
  final bool isDone;
  final bool isImportant;
  final bool protected;
  final String voiceNote;
  final DateTime createAt;

  const Note(
      {this.id,
      required this.name,
      required this.voiceNote,
      required this.description,
      required this.createDate,
      required this.imageUrl,
      required this.protected,
      required this.createAt,
      required this.isImportant,
      required this.isDone});

  Note copyWith({
    int? id,
    String? name,
    String? description,
    String? createDate,
    bool? isDone,
    bool? isImportant,
    bool? protected,
    String? voiceNote,
    String? imageUrl,
    DateTime? createAt,
  }) {
    return Note(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        createDate: createDate ?? this.createDate,
        isDone: isDone ?? this.isDone,
        imageUrl: imageUrl ?? this.imageUrl,
        createAt: createAt ?? this.createAt,
        isImportant: isImportant ?? this.isImportant,
        voiceNote: voiceNote ?? this.voiceNote,
        protected: protected ?? this.protected);
  }

  factory Note.fromJson(Map<String, Object?> json) => Note(
      id: json[NoteFields.id] as int?,
      name: json[NoteFields.name] as String,
      description: json[NoteFields.description] as String,
      createDate: json[NoteFields.createDate] as String,
      isImportant: json[NoteFields.isImportant] == 1,
      imageUrl: json[NoteFields.imageUrl] as String,
      isDone: json[NoteFields.isDone] == 0,
      voiceNote: json[NoteFields.voiceNote] as String,
      createAt: DateTime.parse(json[NoteFields.createAt] as String),
      protected: json[NoteFields.protected] == 0);

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.createDate: createDate,
        NoteFields.description: description,
        NoteFields.name: name,
        NoteFields.isDone: isDone ? 0 : 1,
        NoteFields.protected: protected ? 0 : 1,
        NoteFields.isImportant: isImportant ? 1 : 0,
        NoteFields.voiceNote: voiceNote,
        NoteFields.imageUrl: imageUrl,
        NoteFields.createAt: createAt.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        id,
        createDate,
        description,
        name,
        isDone,
        isImportant,
        voiceNote,
        imageUrl,
        createAt,
        protected
      ];
}
