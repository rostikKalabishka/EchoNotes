part of 'notes_bloc.dart';

sealed class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class LoadNotesEvent extends NotesEvent {}

class OpenNotesEvent extends NotesEvent {
  final int id;

  const OpenNotesEvent({required this.id});

  @override
  List<Object> get props => super.props..add(id);
}
