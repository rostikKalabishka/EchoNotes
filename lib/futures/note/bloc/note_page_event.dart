part of 'note_page_bloc.dart';

sealed class NotePageEvent extends Equatable {
  const NotePageEvent();

  @override
  List<Object> get props => [];
}

class ImagePickerEvent extends NotePageEvent {
  final Note note;

  const ImagePickerEvent({required this.note});
  @override
  List<Object> get props => super.props..addAll([note]);
}

class LoadNoteInfoEvent extends NotePageEvent {
  final int id;

  const LoadNoteInfoEvent({required this.id});

  @override
  List<Object> get props => super.props..add(id);
}

class ChangeNameNoteEvent extends NotePageEvent {
  final Note note;
  final String name;

  const ChangeNameNoteEvent({required this.note, required this.name});
  @override
  List<Object> get props => super.props..addAll([note, name]);
}

class ChangeDescriptionNoteEvent extends NotePageEvent {
  final Note note;
  final String description;
  final BuildContext context;

  const ChangeDescriptionNoteEvent({
    required this.note,
    required this.description,
    required this.context,
  });
  @override
  List<Object> get props => super.props..addAll([note, description, context]);
}

class DeleteNoteEvent extends NotePageEvent {
  final Note note;
  final BuildContext context;

  const DeleteNoteEvent({required this.note, required this.context});
  @override
  List<Object> get props => super.props..addAll([note, context]);
}
