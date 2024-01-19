part of 'add_voice_note_bloc.dart';

sealed class AddVoiceNoteState extends Equatable {
  const AddVoiceNoteState();
  
  @override
  List<Object> get props => [];
}

final class AddVoiceNoteInitial extends AddVoiceNoteState {}
