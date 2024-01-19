import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:note_app/repository/model/model.dart';

@RoutePage()
class NotePage extends StatefulWidget {
  const NotePage({super.key, required this.note});
  final Note note;
  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Change note'),
          )
        ],
      ),
    );
  }
}
