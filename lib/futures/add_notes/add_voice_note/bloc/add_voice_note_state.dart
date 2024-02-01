part of 'add_voice_note_bloc.dart';

class AddVoiceNoteState extends Equatable {
  final bool isListening;
  final String description;
  final double confidence;
  final String name;
  final Object error;
  final String imageUrl;

  const AddVoiceNoteState(
      {this.isListening = false,
      this.description = '',
      this.confidence = 1.0,
      this.name = 'Note',
      this.error = '',
      this.imageUrl = ''});

  @override
  List<Object?> get props =>
      [isListening, description, confidence, name, error, imageUrl];

  AddVoiceNoteState copyWith(
      {bool? isListening,
      String? description,
      double? confidence,
      String? name,
      Object? error,
      String? imageUrl}) {
    return AddVoiceNoteState(
      isListening: isListening ?? this.isListening,
      description: description ?? this.description,
      confidence: confidence ?? this.confidence,
      name: name ?? this.name,
      error: error ?? this.error,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
