import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app/echo_notes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const EchoNotes());
}
