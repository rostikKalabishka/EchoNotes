part of 'notes_bloc.dart';

class NotesState extends Equatable {
  final List<Note> noteList;
  final Object error;
  final bool isLoading;

  const NotesState(
      {this.noteList = const [], this.error = '', this.isLoading = false});
  @override
  List<Object?> get props => [noteList, error, isLoading];

  NotesState copyWith({
    List<Note>? noteList,
    Object? error,
    bool? isLoading,
  }) {
    return NotesState(
      noteList: noteList ?? this.noteList,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
