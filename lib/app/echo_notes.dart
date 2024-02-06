import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:note_app/core/router/router.dart';
import 'package:note_app/futures/account_settings/bloc/account_settings_bloc.dart';

import 'package:note_app/futures/add_list_todo/bloc/add_list_notes_bloc.dart';
import 'package:note_app/futures/add_list_todo/view/add_list_notes.dart';
import 'package:note_app/futures/add_notes/add_default_notes/bloc/add_default_note_bloc.dart';
import 'package:note_app/futures/add_notes/add_voice_note/view/add_voice_note.dart';
import 'package:note_app/futures/current_todo_list_info/bloc/current_todo_list_info_bloc.dart';
import 'package:note_app/futures/list_todo/bloc/list_todo_bloc.dart';

import 'package:note_app/futures/note/bloc/note_page_bloc.dart';
import 'package:note_app/futures/notes/bloc/notes_bloc.dart';
import 'package:note_app/repository/db_repository/abstract_notes_database.dart';
import 'package:note_app/repository/local_auth_repository/abstract_local_auth_repository.dart';
import 'package:note_app/repository/shared_pref_theme/abstract_shared_pref_theme.dart';

import 'package:note_app/core/ui/theme/theme.dart';

import '../futures/add_notes/add_voice_note/bloc/add_voice_note_bloc.dart';

class EchoNotes extends StatefulWidget {
  const EchoNotes({
    super.key,
  });

  @override
  State<EchoNotes> createState() => _EchoNotesState();
}

class _EchoNotesState extends State<EchoNotes> {
  final _appRouter = AppRouter();
  final _accountSettingsBloc = AccountSettingsBloc(
      GetIt.I<AbstractNotesDataBase>(), GetIt.I<AbstractSharedPrefTheme>());
  final _notesBloc = NotesBloc(
      GetIt.I<AbstractNotesDataBase>(), GetIt.I<AbstractLocalAuthRepository>());
  final _addDefaultNoteBloc =
      AddDefaultNoteBloc(GetIt.I<AbstractNotesDataBase>());
  final _notePageBloc = NotePageBloc(
      GetIt.I<AbstractNotesDataBase>(), GetIt.I<AbstractLocalAuthRepository>());
  final _addVoiceNoteBloc = AddVoiceNoteBloc(GetIt.I<AbstractNotesDataBase>());

  final _addListNotesBloc = AddListTodoBloc(GetIt.I<AbstractNotesDataBase>());
  final _listTodoBloc = ListTodoBloc(
      GetIt.I<AbstractNotesDataBase>(),
      GetIt.I<AbstractSharedPrefTheme>(),
      GetIt.I<AbstractLocalAuthRepository>());
  final _currentTodoListInfoBloc = CurrentTodoListInfoBloc(
      GetIt.I<AbstractNotesDataBase>(), GetIt.I<AbstractLocalAuthRepository>());

  @override
  void initState() {
    _accountSettingsBloc.add(LoadInfoEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _accountSettingsBloc),
        BlocProvider(create: (_) => _notesBloc),
        BlocProvider(create: (_) => _addDefaultNoteBloc),
        BlocProvider(create: (_) => _notePageBloc),
        BlocProvider(
          create: (_) => _addVoiceNoteBloc,
          child: const AddVoiceNotePage(),
        ),
        BlocProvider(
          create: (_) => _addListNotesBloc,
          child: const AddListTodoPage(),
        ),
        BlocProvider(create: (_) => _listTodoBloc),
        BlocProvider(create: (_) => _currentTodoListInfoBloc)
      ],
      child: BlocBuilder<AccountSettingsBloc, AccountSettingsState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: state.switchBoolTheme == true
                ? ThemeMode.dark
                : ThemeMode.light,
            routerDelegate: AutoRouterDelegate(
              _appRouter,
              navigatorObservers: () => [AutoRouteObserver()],
            ),
            routeInformationParser: _appRouter.defaultRouteParser(),
          );
        },
      ),
    );
  }
}
