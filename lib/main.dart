import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import 'package:note_app/app/echo_notes.dart';
import 'package:note_app/core/di/di.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final LocalAuthentication auth = LocalAuthentication();
  await initDI(sharedPreferences, auth);
  runApp(const EchoNotes());
}
