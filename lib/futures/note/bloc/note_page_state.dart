part of 'note_page_bloc.dart';

sealed class NotePageState extends Equatable {
  const NotePageState();
  
  @override
  List<Object> get props => [];
}

final class NotePageInitial extends NotePageState {}
