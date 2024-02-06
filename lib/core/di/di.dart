import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:note_app/repository/db_repository/notes_database.dart';
import 'package:note_app/repository/local_auth_repository/abstract_local_auth_repository.dart';
import 'package:note_app/repository/local_auth_repository/local_auth_repository.dart';
import 'package:note_app/repository/shared_pref_theme/abstract_shared_pref_theme.dart';
import 'package:note_app/repository/shared_pref_theme/shared_pref_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repository/db_repository/abstract_notes_database.dart';

final di = GetIt.I;
Future<void> initDI(
    SharedPreferences sharedPreferences, LocalAuthentication auth) async {
  di.registerLazySingleton<AbstractNotesDataBase>(() => NotesDatabase());
  di.registerLazySingleton<AbstractSharedPrefTheme>(
    () => SharedPrefTheme(prefs: sharedPreferences),
  );

  di.registerLazySingleton<AbstractLocalAuthRepository>(
    () => LocalAuthRepository(
      auth: auth,
    ),
  );
}
