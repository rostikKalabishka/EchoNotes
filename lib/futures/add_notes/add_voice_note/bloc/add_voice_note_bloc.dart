import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:note_app/repository/db_repository/abstract_notes_database.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

part 'add_voice_note_event.dart';
part 'add_voice_note_state.dart';

class AddVoiceNoteBloc extends Bloc<AddVoiceNoteEvent, AddVoiceNoteState> {
  final AbstractNotesDataBase abstractNotesDataBase;
  final speech = stt.SpeechToText();
  AddVoiceNoteBloc(this.abstractNotesDataBase)
      : super(const AddVoiceNoteState()) {
    on<AddVoiceNoteEvent>((event, emit) async {
      if (event is CreateNameNoteEvent) {
      } else if (event is ChangeDescriptionEvent) {
      } else if (event is SpeechToTextEvent) {
        await _speechToTextEventListen(event, emit);
      }
    });
  }

  Future<void> _speechToTextEventListen(
      SpeechToTextEvent event, Emitter<AddVoiceNoteState> emit) async {
    try {
      if (!state.isListening) {
        bool available = await speech.initialize(
            onStatus: (value) => log('onStatus :$value'),
            onError: (value) => log('onError :$value'));
        if (available) {
          emit(state.copyWith(isListening: true));
          speech.listen(onResult: (value) {
            emit(state.copyWith(description: value.recognizedWords));
            log(value.recognizedWords);
            if (value.hasConfidenceRating && value.confidence > 0) {
              emit(state.copyWith(confidence: value.confidence));
            }
          });
        }
      } else {
        emit(state.copyWith(
          isListening: false,
        ));
        speech.stop();
      }
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }
}
