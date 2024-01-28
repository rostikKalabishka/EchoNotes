import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note_app/repository/db_repository/abstract_notes_database.dart';
import 'package:note_app/repository/model/todo.dart';
import 'package:note_app/repository/model/todo_list.dart';

part 'current_todo_list_info_event.dart';
part 'current_todo_list_info_state.dart';

class CurrentTodoListInfoBloc
    extends Bloc<CurrentTodoListInfoEvent, CurrentTodoListInfoState> {
  final AbstractNotesDataBase abstractNotesDataBase;
  CurrentTodoListInfoBloc(this.abstractNotesDataBase)
      : super(const CurrentTodoListInfoState()) {
    on<CurrentTodoListInfoEvent>((event, emit) async {
      if (event is LoadTodoListEvent) {
        await _loadTodoList(event, emit);
      }
    });
  }
  Future<void> _loadTodoList(
      LoadTodoListEvent event, Emitter<CurrentTodoListInfoState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final todoList =
          await abstractNotesDataBase.readTodoList(event.todoList.id!);
      emit(state.copyWith(
          isLoading: false,
          // listTodo: ,
          name: todoList.name));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e));
    }
  }
}