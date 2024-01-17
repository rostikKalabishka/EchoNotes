part of 'notes_bloc.dart';

sealed class NotesState extends Equatable {
  const NotesState();
  
  @override
  List<Object> get props => [];
}

final class NotesInitial extends NotesState {}
