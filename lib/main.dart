import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:note_app/app/echo_notes.dart';

import 'package:note_app/repository/db_repository/abstract_notes_database.dart';
import 'package:note_app/repository/db_repository/notes_database.dart';
import 'package:note_app/repository/shared_pref_theme/abstract_shared_pref_theme.dart';
import 'package:note_app/repository/shared_pref_theme/shared_pref_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  GetIt.I.registerLazySingleton<AbstractNotesDataBase>(() => NotesDatabase());
  GetIt.I.registerLazySingleton<AbstractSharedPrefTheme>(
      () => SharedPrefTheme(prefs: sharedPreferences));
  runApp(const EchoNotes());
}
