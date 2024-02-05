import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  await initDI(sharedPreferences);
  runApp(const EchoNotes());
}
