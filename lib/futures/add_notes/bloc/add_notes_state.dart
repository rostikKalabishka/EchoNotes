part of 'add_notes_bloc.dart';

sealed class AddNotesState extends Equatable {
  const AddNotesState();
  
  @override
  List<Object> get props => [];
}

final class AddNotesInitial extends AddNotesState {}
