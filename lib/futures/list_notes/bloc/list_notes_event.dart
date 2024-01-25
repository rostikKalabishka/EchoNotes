part of 'list_notes_bloc.dart';

sealed class ListNotesEvent extends Equatable {
  const ListNotesEvent();

  @override
  List<Object> get props => [];
}

class NavigateToAddListNotesEvent extends ListNotesEvent {
  final BuildContext context;

  const NavigateToAddListNotesEvent({required this.context});
  @override
  List<Object> get props => super.props..addAll([context]);
}
