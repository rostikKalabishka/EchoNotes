import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:note_app/futures/note/bloc/note_page_bloc.dart';
import 'package:note_app/futures/note/widgets/custom_button_widget.dart';
import 'package:note_app/repository/model/model.dart';
import 'package:note_app/core/ui/widgets/widget.dart';
import 'package:note_app/core/utilities/utilities.dart';

@RoutePage()
class NotePage extends StatefulWidget {
  const NotePage({Key? key, required this.note}) : super(key: key);
  final Note note;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final TextEditingController changeNameNote = TextEditingController();
  late final TextEditingController changeNote =
      TextEditingController(text: widget.note.description);
  final _formKey = GlobalKey<FormState>();
  final Utilities utilities = Utilities();
  @override
  void initState() {
    context.read<NotePageBloc>().add(LoadNoteInfoEvent(id: widget.note.id!));

    super.initState();
  }

  bool play = false;
  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    final double modalHeight = size.height * 0.45;
    final double modalAddTodoHeight = size.height * 0.7;

    return BlocBuilder<NotePageBloc, NotePageState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: CustomFloatingActionButton(
            height: size.height * 0.075,
            width: size.height * 0.075,
            borderRadius: BorderRadius.circular(12),
            onPressed: () {
              showModalMenuBottomSheet(
                  context: context,
                  modalHeight: modalHeight,
                  child: MenuWidget(
                    note: widget.note,
                    utilities: utilities,
                    controller: changeNameNote,
                    formKey: _formKey,
                  ));
            },
            dataButton: const Icon(FontAwesomeIcons.plus),
            heroTag: 'add_change_note',
          ),
          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text(
                      state.name,
                      style: theme.textTheme.labelLarge,
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          showModalMenuBottomSheet(
                              context: context,
                              modalHeight: modalHeight,
                              child: MenuWidget(
                                note: widget.note,
                                utilities: utilities,
                                controller: changeNameNote,
                                formKey: _formKey,
                              ));
                        },
                        icon: const Icon(Icons.more_horiz),
                      ),
                    ],
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 30,
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          CustomBoxShadowContainer(
                            width: size.height * 0.9,
                            cardColor: theme.cardColor,
                            cardInfo: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: GestureDetector(
                                    onLongPress: () {
                                      showModalMenuBottomSheet(
                                        context: context,
                                        modalHeight: modalAddTodoHeight,
                                        child: AddNode(
                                          addTodoController: changeNote,
                                          utilities: utilities,
                                          formKey: _formKey,
                                          note: widget.note,
                                        ),
                                      );
                                    },
                                    child: Text(
                                      state.description,
                                      style: theme.textTheme.labelLarge,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          state.selectedImage.isNotEmpty
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.54,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: utilities.imageFromBase64String(
                                          state.selectedImage),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: bottomPadding,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButtonWidget(
                        theme: theme,
                        size: size,
                        onTap: () {},
                        child: Text(
                          'EN',
                          style: theme.textTheme.labelMedium,
                        ),
                      ),
                      CustomButtonWidget(
                        theme: theme,
                        size: size,
                        onTap: () {
                          context
                              .read<NotePageBloc>()
                              .add(ImagePickerEvent(note: widget.note));
                        },
                        child: const Icon(Icons.attachment),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    Key? key,
    required this.note,
    required this.utilities,
    required this.controller,
    required this.formKey,
  }) : super(key: key);
  final Note note;
  final Utilities utilities;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                Text(
                  'Menu',
                  style: theme.textTheme.labelLarge,
                ),
                IconButton(
                  onPressed: () {
                    AutoRouter.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                children: [
                  ButtonInBottomSheet(
                    backgroundColor: const Color.fromARGB(187, 191, 179, 4),
                    onTap: () {
                      openDialog(
                          validator: (val) =>
                              utilities.textFieldValidator(val!),
                          context: context,
                          state: NotePageBloc,
                          controller: controller,
                          saveName: () {
                            if (formKey.currentState!.validate()) {
                              context.read<NotePageBloc>().add(
                                  ChangeNameNoteEvent(
                                      name: controller.text.isNotEmpty
                                          ? controller.text
                                          : 'Note',
                                      note: note));
                            }
                          });
                      controller.clear();
                    },
                    iconColor: Colors.yellow,
                    icon: Icons.edit_outlined,
                    text: 'Change note name',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ButtonInBottomSheet(
                    backgroundColor: const Color.fromARGB(255, 6, 70, 246),
                    onTap: () {},
                    iconColor: Colors.blue,
                    icon: FontAwesomeIcons.faceDizzy,
                    text: 'Delete note',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ButtonInBottomSheet(
                    backgroundColor: const Color.fromARGB(255, 156, 77, 77),
                    onTap: () {
                      context
                          .read<NotePageBloc>()
                          .add(DeleteNoteEvent(note: note, context: context));
                    },
                    iconColor: Colors.red,
                    icon: Icons.delete_outline,
                    text: 'Delete note',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddNode extends StatelessWidget {
  const AddNode({
    Key? key,
    required this.addTodoController,
    required this.utilities,
    required this.formKey,
    required this.note,
  }) : super(key: key);
  final TextEditingController addTodoController;
  final Utilities utilities;
  final GlobalKey<FormState> formKey;
  final Note note;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
            ),
            Text(
              'Change description',
              style: theme.textTheme.labelLarge,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            IconButton(
              onPressed: () {
                AutoRouter.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextField(
                  mixLines: 1,
                  validator: (value) => utilities.textFieldValidator(value!),
                  hintText: 'Add note name',
                  textEditorController: addTodoController,
                  maxLines: 15,
                  autofocus: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<NotePageBloc>().add(
                              ChangeDescriptionNoteEvent(
                                  description: addTodoController.text,
                                  context: context,
                                  note: note),
                            );
                        addTodoController.clear();
                      }
                    },
                    child: Text(
                      'add todo',
                      style: theme.textTheme.labelLarge,
                    ))
              ],
            ),
          ),
        )
      ],
    );
  }
}
