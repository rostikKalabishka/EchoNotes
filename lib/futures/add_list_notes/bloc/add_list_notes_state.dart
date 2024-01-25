part of 'add_list_notes_bloc.dart';

sealed class AddListNotesState extends Equatable {
  const AddListNotesState();
  
  @override
  List<Object> get props => [];
}

final class AddListNotesInitial extends AddListNotesState {}
