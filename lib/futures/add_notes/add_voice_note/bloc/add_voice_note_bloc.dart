import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:note_app/repository/db_repository/abstract_notes_database.dart';
import 'package:note_app/repository/model/note.dart';
import 'package:note_app/router/router.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

part 'add_voice_note_event.dart';
part 'add_voice_note_state.dart';

class AddVoiceNoteBloc extends Bloc<AddVoiceNoteEvent, AddVoiceNoteState> {
  final AbstractNotesDataBase abstractNotesDataBase;
  final speech = stt.SpeechToText();
  String description = '';
  AddVoiceNoteBloc(this.abstractNotesDataBase)
      : super(const AddVoiceNoteState()) {
    on<AddVoiceNoteEvent>((event, emit) async {
      if (event is CreateNameNoteEvent) {
        _changeName(event, emit);
      } else if (event is ChangeDescriptionEvent) {
        _changeDescription(event, emit);
      } else if (event is SpeechToTextEvent) {
        await _speechToTextEventListen(event, emit);
      } else if (event is LoadBaseData) {
        initBaseData(event, emit);
      } else if (event is ImagePickerEvent) {
        await _pickImage(event, emit);
      } else if (event is AddNoteEvent) {
        await _addNote(event, emit);
      }
    }, transformer: sequential());
  }

  void _changeName(CreateNameNoteEvent event, Emitter<AddVoiceNoteState> emit) {
    final autoRouter = AutoRouter.of(event.context);
    try {
      emit(state.copyWith(name: event.name));
      autoRouter.pop();
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  void _changeDescription(
      ChangeDescriptionEvent event, Emitter<AddVoiceNoteState> emit) {
    final autoRouter = AutoRouter.of(event.context);
    try {
      emit(state.copyWith(description: event.description));
      autoRouter.pop();
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _addNote(
      AddNoteEvent event, Emitter<AddVoiceNoteState> emit) async {
    final autoRoute = AutoRouter.of(event.context);
    try {
      final createDate = DateFormat('dd.MM.yyyy').format(DateTime.now());

      final note = Note(
          name: state.name,
          voiceNote: '',
          description: state.description,
          createDate: createDate,
          imageUrl: state.imageUrl,
          isImportant: false,
          isDone: false);

      await abstractNotesDataBase.createNotes(note);
      emit(state);

      autoRoute.pushAndPopUntil(const NotesRoute(),
          predicate: (route) => false);
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _pickImage(
      ImagePickerEvent event, Emitter<AddVoiceNoteState> emit) async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
      emit(state.copyWith(imageUrl: file!.path));
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  void initBaseData(LoadBaseData event, Emitter<AddVoiceNoteState> emit) {
    emit(state.copyWith(
        name: 'Note', description: '', imageUrl: '', isListening: false));
  }

  Future<void> _speechToTextEventListen(
      SpeechToTextEvent event, Emitter<AddVoiceNoteState> emit) async {
    double confidence = state.confidence;

    try {
      if (!state.isListening) {
        bool available = await speech.initialize(
          onStatus: (value) => log('onStatus :$value'),
          onError: (value) => log('onError :$value'),
        );
        if (available) {
          emit(state.copyWith(isListening: true));

          await speech.listen(onResult: (value) {
            // try {
            log('Recognized words : ${value.recognizedWords}');
            description = value.recognizedWords;
            // emit(state.copyWith(description: description));
            // } catch (e) {
            //   log('Error during emit: $e');
            // }
          });
        }
      } else {
        emit(state.copyWith(
            isListening: false,
            confidence: confidence,
            description: description));
        await speech.stop();
      }
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }
}
