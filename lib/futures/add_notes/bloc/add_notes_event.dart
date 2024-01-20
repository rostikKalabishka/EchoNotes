part of 'add_notes_bloc.dart';

sealed class AddNotesEvent extends Equatable {
  const AddNotesEvent();

  @override
  List<Object> get props => [];
}

class NavigateToAddVoiceNotePage extends AddNotesEvent {
  final BuildContext context;

  const NavigateToAddVoiceNotePage({required this.context});

  @override
  List<Object> get props => super.props..addAll([context]);
}

class NavigateToAddNotePage extends AddNotesEvent {
  final BuildContext context;

  const NavigateToAddNotePage({required this.context});

  @override
  List<Object> get props => super.props..addAll([context]);
}
