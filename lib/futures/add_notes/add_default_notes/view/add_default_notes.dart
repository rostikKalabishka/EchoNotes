import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/futures/add_notes/add_default_notes/bloc/add_default_note_bloc.dart';
import 'package:note_app/ui/widgets/widget.dart';

@RoutePage()
class AddDefaultNotesPage extends StatefulWidget {
  const AddDefaultNotesPage({super.key});

  @override
  State<AddDefaultNotesPage> createState() => _AddDefaultNotesPageState();
}

class _AddDefaultNotesPageState extends State<AddDefaultNotesPage> {
  final TextEditingController noteName = TextEditingController();
  final TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddDefaultNoteBloc, AddDefaultNoteState>(
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: const Text('Add new note'),
                actions: [
                  TextButton(onPressed: () {}, child: const Text('Add'))
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: 'Add note name',
                      textEditorController: noteName,
                      maxLines: 1,
                    ),
                    CustomTextField(
                      hintText: 'Add description',
                      textEditorController: description,
                      maxLines: 25,
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
