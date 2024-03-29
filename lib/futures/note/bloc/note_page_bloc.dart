import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app/core/router/router.dart';
import 'package:note_app/repository/db_repository/abstract_notes_database.dart';

import 'package:note_app/core/utilities/utilities.dart';
import 'package:note_app/repository/local_auth_repository/abstract_local_auth_repository.dart';

import '../../../repository/model/model.dart';

part 'note_page_event.dart';
part 'note_page_state.dart';

class NotePageBloc extends Bloc<NotePageEvent, NotePageState> {
  final AbstractNotesDataBase abstractNotesDataBase;
  final AbstractLocalAuthRepository abstractLocalAuthRepository;
  final utilities = Utilities();
  NotePageBloc(this.abstractNotesDataBase, this.abstractLocalAuthRepository)
      : super(const NotePageState()) {
    on<NotePageEvent>(
      (event, emit) async {
        if (event is ImagePickerEvent) {
          await _pickImage(event, emit);
        } else if (event is LoadNoteInfoEvent) {
          await _loadNote(event, emit);
        } else if (event is DeleteNoteEvent) {
          await _deleteNote(event, emit);
        } else if (event is ChangeNameNoteEvent) {
          await _changeNameNote(event, emit);
        } else if (event is ChangeDescriptionNoteEvent) {
          await _changeNoteDescription(event, emit);
        } else if (event is AddProtectedEvent) {
          await _addProtected(event, emit);
        } else if (event is RemoveProtectedEvent) {
          await _removeProtected(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  Future<void> _pickImage(
      ImagePickerEvent event, Emitter<NotePageState> emit) async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

      if (file != null) {
        String imgString = utilities.base64String(await file.readAsBytes());
        emit(state.copyWith(selectedImage: imgString));
        await abstractNotesDataBase
            .updateNote(event.note.copyWith(imageUrl: imgString));
      } else {
        emit(state.copyWith(error: 'No image selected'));
      }
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _addProtected(
      AddProtectedEvent event, Emitter<NotePageState> emit) async {
    try {
      final protected = await abstractLocalAuthRepository.authenticate();
      if (protected) {
        emit(state.copyWith(protected: true));
        await abstractNotesDataBase
            .updateNote(event.note.copyWith(protected: true));
      }
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _removeProtected(
      RemoveProtectedEvent event, Emitter<NotePageState> emit) async {
    try {
      final protected = await abstractLocalAuthRepository.authenticate();
      if (protected) {
        emit(state.copyWith(protected: false));
        await abstractNotesDataBase
            .updateNote(event.note.copyWith(protected: false));
      }
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _changeNameNote(
      ChangeNameNoteEvent event, Emitter<NotePageState> emit) async {
    try {
      emit(state.copyWith(name: event.name));
      await abstractNotesDataBase
          .updateNote(event.note.copyWith(name: event.name));
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _changeNoteDescription(
      ChangeDescriptionNoteEvent event, Emitter<NotePageState> emit) async {
    final autoRoute = AutoRouter.of(event.context);
    try {
      await abstractNotesDataBase
          .updateNote(event.note.copyWith(description: event.description));
      emit(state.copyWith(description: event.description));
      autoRoute.pop();
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _loadNote(
      LoadNoteInfoEvent event, Emitter<NotePageState> emit) async {
    try {
      final Note note = await abstractNotesDataBase.readNote(event.id);
      emit(state.copyWith(
          protected: note.protected,
          description: note.description,
          name: note.name,
          voice: note.voiceNote,
          selectedImage: note.imageUrl,
          createDate: note.createDate));
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _deleteNote(
      DeleteNoteEvent event, Emitter<NotePageState> emit) async {
    final autoRouter = AutoRouter.of(event.context);

    try {
      await abstractNotesDataBase.deleteNote(event.note);
      autoRouter.pushAndPopUntil(const NotesRoute(),
          predicate: (route) => false);
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }
}
