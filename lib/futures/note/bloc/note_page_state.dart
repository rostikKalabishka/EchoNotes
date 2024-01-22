part of 'note_page_bloc.dart';

class NotePageState extends Equatable {
  const NotePageState(
      {this.error = '',
      this.selectedImage = '',
      this.voice = '',
      this.note = ''});
  final Object error;
  final String selectedImage;
  final String voice;
  final String note;

  @override
  List<Object> get props => [error, selectedImage, voice, note];

  NotePageState copyWith(
      {Object? error, String? selectedImage, String? voice, String? note}) {
    return NotePageState(
      note: note ?? this.note,
      voice: voice ?? this.voice,
      error: error ?? this.error,
      selectedImage: selectedImage ?? this.selectedImage,
    );
  }
}
