part of 'add_default_note_bloc.dart';

sealed class AddDefaultNoteEvent extends Equatable {
  const AddDefaultNoteEvent();

  @override
  List<Object> get props => [];
}

class AddDefaultNote extends AddDefaultNoteEvent {
  final String noteName;
  final String description;
  final BuildContext context;

  const AddDefaultNote({
    required this.noteName,
    required this.description,
    required this.context,
  });

  @override
  List<Object> get props =>
      super.props..addAll([noteName, description, context]);
}
