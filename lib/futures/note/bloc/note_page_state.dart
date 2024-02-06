part of 'note_page_bloc.dart';

class NotePageState extends Equatable {
  const NotePageState({
    this.protected = false,
    this.error = '',
    this.createDate = '',
    this.selectedImage = '',
    this.voice = '',
    this.description = '',
    this.name = '',
  });

  final Object error;
  final String selectedImage;
  final String voice;
  final String createDate;
  final String description;
  final String name;
  final bool protected;

  @override
  List<Object> get props =>
      [error, selectedImage, voice, description, name, protected];

  NotePageState copyWith(
      {Object? error,
      String? selectedImage,
      String? voice,
      String? createDate,
      String? description,
      String? name,
      bool? protected}) {
    return NotePageState(
        name: name ?? this.name,
        description: description ?? this.description,
        voice: voice ?? this.voice,
        error: error ?? this.error,
        selectedImage: selectedImage ?? this.selectedImage,
        protected: protected ?? this.protected);
  }
}
