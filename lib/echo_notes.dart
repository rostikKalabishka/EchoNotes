import 'package:flutter/material.dart';

import 'package:note_app/router/router.dart';

import 'futures/home/home.dart';

class EchoNotes extends StatefulWidget {
  const EchoNotes({super.key});

  @override
  State<EchoNotes> createState() => _EchoNotesState();
}

class _EchoNotesState extends State<EchoNotes> {
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        //  routerConfig: _appRouter.config(),
        home: HomePage());
  }
}
