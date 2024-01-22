const String tableNotes = 'notes';

class NoteFields {
  static const List<String> values = [
    id,
    isImportant,
    name,
    description,
    isDone,
    createDate,
    voiceNote
  ];

  static const String id = '_id';
  static const String isImportant = 'isImportant';
  static const String name = 'name';
  static const String description = 'description';
  static const String isDone = 'isDone';
  static const String createDate = 'createDate';
  static const String voiceNote = 'voiceNote';
}

class Note {
  final int? id;
  final String name;
  final String description;
  final String createDate;
  final bool isDone;
  final bool isImportant;
  final String voiceNote;

  Note(
      {this.id,
      required this.name,
      required this.voiceNote,
      required this.description,
      required this.createDate,
      required this.isImportant,
      required this.isDone});

  Note copyWith({
    int? id,
    String? name,
    String? description,
    String? createDate,
    bool? isDone,
    bool? isImportant,
    String? voiceNote,
  }) {
    return Note(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        createDate: createDate ?? this.createDate,
        isDone: isDone ?? this.isDone,
        isImportant: isImportant ?? this.isImportant,
        voiceNote: voiceNote ?? this.voiceNote);
  }

  factory Note.fromJson(Map<String, Object?> json) => Note(
      id: json[NoteFields.id] as int?,
      name: json[NoteFields.name] as String,
      description: json[NoteFields.description] as String,
      createDate: json[NoteFields.createDate] as String,
      isImportant: json[NoteFields.isImportant] as bool,
      isDone: json[NoteFields.isDone] as bool,
      voiceNote: json[NoteFields.voiceNote] as String);

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.createDate: createDate,
        NoteFields.description: description,
        NoteFields.name: name,
        NoteFields.isDone: isDone,
        NoteFields.isImportant: isImportant
      };
}