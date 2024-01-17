part of 'list_notes_bloc.dart';

sealed class ListNotesState extends Equatable {
  const ListNotesState();
  
  @override
  List<Object> get props => [];
}

final class ListNotesInitial extends ListNotesState {}
