part of 'note_page_bloc.dart';

sealed class NotePageEvent extends Equatable {
  const NotePageEvent();

  @override
  List<Object> get props => [];
}

class ImagePickerEvent extends NotePageEvent {}

class LoadNoteInfoEvent extends NotePageEvent {
  final int id;

  const LoadNoteInfoEvent({required this.id});

  @override
  List<Object> get props => super.props..add(id);
}

class DeleteNoteEvent extends NotePageEvent {
  final Note note;
  final BuildContext context;

  const DeleteNoteEvent({required this.note, required this.context});
  @override
  List<Object> get props => super.props..addAll([note, context]);
}
