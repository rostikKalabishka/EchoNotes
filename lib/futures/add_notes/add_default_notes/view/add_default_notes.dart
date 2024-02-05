import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/futures/add_notes/add_default_notes/bloc/add_default_note_bloc.dart';
import 'package:note_app/core/ui/widgets/widget.dart';

import '../../../../core/utilities/utilities.dart';

@RoutePage()
class AddDefaultNotesPage extends StatefulWidget {
  const AddDefaultNotesPage({super.key});

  @override
  State<AddDefaultNotesPage> createState() => _AddDefaultNotesPageState();
}

class _AddDefaultNotesPageState extends State<AddDefaultNotesPage> {
  final TextEditingController noteName = TextEditingController();
  final TextEditingController description = TextEditingController();
  final _utilities = Utilities();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<AddDefaultNoteBloc, AddDefaultNoteState>(
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: const Text('Add new note'),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AddDefaultNoteBloc>().add(
                              AddDefaultNote(
                                  noteName: noteName.text,
                                  description: description.text,
                                  context: context),
                            );
                      }
                    },
                    child: Icon(
                      FontAwesomeIcons.plus,
                      color: theme.iconTheme.color,
                    ),
                  )
                ],
              ),
              SliverToBoxAdapter(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        validator: (value) =>
                            _utilities.textFieldValidator(value!),
                        hintText: 'Add note name',
                        textEditorController: noteName,
                        maxLines: 1,
                        autofocus: false,
                      ),
                      CustomTextField(
                        validator: (value) =>
                            _utilities.textFieldValidator(value!),
                        hintText: 'Add description',
                        textEditorController: description,
                        maxLines: 23,
                        autofocus: false,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
