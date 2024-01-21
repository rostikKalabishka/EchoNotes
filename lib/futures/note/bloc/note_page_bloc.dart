import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'note_page_event.dart';
part 'note_page_state.dart';

class NotePageBloc extends Bloc<NotePageEvent, NotePageState> {
  NotePageBloc() : super(const NotePageState()) {
    on<NotePageEvent>((event, emit) async {
      if (event is ImagePickerEvent) {
        await _pickImage(event, emit);
      }
    });
  }

  Future<void> _pickImage(
      ImagePickerEvent event, Emitter<NotePageState> emit) async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
      emit(state.copyWith(selectedImage: file!.path));
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }
}
