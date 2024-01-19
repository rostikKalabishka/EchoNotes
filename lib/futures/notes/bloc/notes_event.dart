part of 'notes_bloc.dart';

sealed class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class LoadNotesEvent extends NotesEvent {}

class OpenNotesEvent extends NotesEvent {
  final Note note;
  final BuildContext context;

  const OpenNotesEvent({required this.note, required this.context});

  @override
  List<Object> get props => super.props..addAll([note, context]);
}

class OpenAddPage extends NotesEvent {
  final BuildContext context;

  const OpenAddPage({required this.context});

  @override
  List<Object> get props => super.props..addAll([context]);
}
