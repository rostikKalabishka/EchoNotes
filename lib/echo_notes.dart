import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/futures/account_settings/bloc/account_settings_bloc.dart';
import 'package:note_app/futures/add_notes/add_default_notes/bloc/add_default_note_bloc.dart';
import 'package:note_app/futures/note/bloc/note_page_bloc.dart';
import 'package:note_app/futures/notes/bloc/notes_bloc.dart';
import 'package:note_app/router/router.dart';
import 'package:note_app/ui/theme/theme.dart';

import 'futures/add_notes/add_voice_note/bloc/add_voice_note_bloc.dart';

class EchoNotes extends StatefulWidget {
  const EchoNotes({super.key});

  @override
  State<EchoNotes> createState() => _EchoNotesState();
}

class _EchoNotesState extends State<EchoNotes> {
  final _appRouter = AppRouter();
  final _accountSettingsBloc = AccountSettingsBloc();
  final _notesBloc = NotesBloc();
  final _addDefaultNoteBloc = AddDefaultNoteBloc();
  final _notePageBloc = NotePageBloc();
  final _addVoiceNoteBloc = AddVoiceNoteBloc();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _accountSettingsBloc),
        BlocProvider(create: (_) => _notesBloc),
        BlocProvider(create: (_) => _addDefaultNoteBloc),
        BlocProvider(create: (_) => _notePageBloc),
        BlocProvider(create: (_) => _addVoiceNoteBloc),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightTheme,
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
