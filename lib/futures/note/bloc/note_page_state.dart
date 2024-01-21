// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'note_page_bloc.dart';

class NotePageState extends Equatable {
  const NotePageState({this.error = '', this.selectedImage = ''});
  final Object error;
  final String selectedImage;

  @override
  List<Object> get props => [error, selectedImage];

  NotePageState copyWith({
    Object? error,
    String? selectedImage,
  }) {
    return NotePageState(
      error: error ?? this.error,
      selectedImage: selectedImage ?? this.selectedImage,
    );
  }
}
