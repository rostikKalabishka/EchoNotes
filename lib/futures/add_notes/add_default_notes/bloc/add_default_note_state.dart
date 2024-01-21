// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_default_note_bloc.dart';

class AddDefaultNoteState extends Equatable {
  const AddDefaultNoteState({
    this.noteName = '',
    this.description = '',
    this.error = '',
  });
  final String noteName;
  final String description;
  final Object error;
  @override
  List<Object> get props => [noteName, description, error];

  AddDefaultNoteState copyWith(
      {String? noteName, String? description, Object? error}) {
    return AddDefaultNoteState(
      error: error ?? this.error,
      noteName: noteName ?? this.noteName,
      description: description ?? this.description,
    );
  }
}
