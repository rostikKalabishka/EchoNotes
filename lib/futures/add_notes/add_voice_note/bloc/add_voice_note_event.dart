part of 'add_voice_note_bloc.dart';

sealed class AddVoiceNoteEvent extends Equatable {
  const AddVoiceNoteEvent();

  @override
  List<Object> get props => [];
}

class CreateNameNoteEvent extends AddVoiceNoteEvent {
  final String name;
  final BuildContext context;

  const CreateNameNoteEvent({required this.name, required this.context});
  @override
  List<Object> get props => super.props..addAll([name, context]);
}

class ChangeDescriptionEvent extends AddVoiceNoteEvent {
  final String description;
  final BuildContext context;

  const ChangeDescriptionEvent(
      {required this.description, required this.context});
  @override
  List<Object> get props => super.props..addAll([description, context]);
}

class SpeechToTextEvent extends AddVoiceNoteEvent {}
