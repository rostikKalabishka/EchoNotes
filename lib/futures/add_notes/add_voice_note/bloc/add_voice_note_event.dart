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

class ImagePickerEvent extends AddVoiceNoteEvent {}

class ChangeDescriptionEvent extends AddVoiceNoteEvent {
  final String description;
  final BuildContext context;

  const ChangeDescriptionEvent(
      {required this.description, required this.context});
  @override
  List<Object> get props => super.props..addAll([description, context]);
}

class LoadBaseData extends AddVoiceNoteEvent {}

class SpeechToTextEvent extends AddVoiceNoteEvent {}

class AddNoteEvent extends AddVoiceNoteEvent {
  final BuildContext context;

  const AddNoteEvent({required this.context});
  @override
  List<Object> get props => super.props..addAll([context]);
}
