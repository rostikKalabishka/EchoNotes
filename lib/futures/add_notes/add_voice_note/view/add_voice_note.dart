import 'package:auto_route/auto_route.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'package:note_app/futures/add_notes/add_voice_note/bloc/add_voice_note_bloc.dart';
import 'package:note_app/futures/note/widgets/custom_button_widget.dart';

import 'package:note_app/ui/widgets/widget.dart';
import 'package:note_app/utilities/utilities.dart';

@RoutePage()
class AddVoiceNotePage extends StatefulWidget {
  const AddVoiceNotePage({super.key});

  @override
  State<AddVoiceNotePage> createState() => _AddVoiceNotePageState();
}

class _AddVoiceNotePageState extends State<AddVoiceNotePage> {
  final utilities = Utilities();
  final _formKey = GlobalKey<FormState>();
  final editNameController = TextEditingController();

  @override
  void initState() {
    context.read<AddVoiceNoteBloc>().add(LoadBaseData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    final Size size = MediaQuery.of(context).size;
    final double modalHeight = size.height * 0.4;
    final double modalChangeDescription = size.height * 0.9;
    final theme = Theme.of(context);

    return BlocConsumer<AddVoiceNoteBloc, AddVoiceNoteState>(
      listener: (context, state) {
        String _errorMsg = '';
        if (state.error.toString().isNotEmpty) {
          _errorMsg = state.error.toString();
          utilities.errorSnackBar(
              errorMsg: _errorMsg, context: context, theme: theme);
        } else {
          _errorMsg = '';
        }
      },
      builder: (context, state) {
        final editDescriptionController =
            TextEditingController(text: state.description);
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: AvatarGlow(
            animate: state.isListening,
            duration: const Duration(microseconds: 2000),
            glowColor:
                theme.floatingActionButtonTheme.backgroundColor!.withOpacity(1),
            glowRadiusFactor: 1,
            repeat: true,
            child: CustomFloatingActionButton(
              height: size.height * 0.075,
              width: size.height * 0.075,
              borderRadius: BorderRadius.circular(20),
              onPressed: () {
                context.read<AddVoiceNoteBloc>().add(SpeechToTextEvent());
              },
              dataButton: Icon(state.isListening == true
                  ? Icons.mic_off_outlined
                  : Icons.mic_outlined),
            ),
          ),
          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text(state.name),
                    actions: [
                      IconButton(
                        onPressed: () {
                          showModalMenuBottomSheet(
                              context: context,
                              modalHeight: modalHeight,
                              child: MenuWidget(
                                utilities: utilities,
                                controller: editNameController,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        children: [
                          state.description.isEmpty
                              ? Lottie.asset('assets/lottie/voice.json',
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) {
                                  return Text('$error');
                                })
                              : GestureDetector(
                                  onLongPress: () {
                                    showModalMenuBottomSheet(
                                      context: context,
                                      modalHeight: modalChangeDescription,
                                      child: ChangeDescriptionWidget(
                                        addTodoController:
                                            editDescriptionController,
                                        utilities: utilities,
                                        formKey: _formKey,
                                        //description: state.description,
                                      ),
                                    );
                                  },
                                  child: CustomBoxShadowContainer(
                                    width: size.width * 0.95,
                                    cardInfo: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Text(
                                        state.description,
                                        style: theme.textTheme.labelLarge,
                                      ),
                                    ),
                                    cardColor: theme.cardColor,
                                  ),
                                ),
                          state.imageUrl.isNotEmpty
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
                                        child: Image.asset(state.imageUrl)),
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
                              .read<AddVoiceNoteBloc>()
                              .add(ImagePickerEvent());
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
    super.key,
    required this.utilities,
    required this.controller,
    required this.formKey,
  });
  final Utilities utilities;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
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
                      validator: (val) => utilities.textFieldValidator(val!),
                      context: context,
                      state: AddVoiceNoteState,
                      controller: controller,
                      saveName: () {
                        context.read<AddVoiceNoteBloc>().add(
                            CreateNameNoteEvent(
                                name: controller.text, context: context));
                        controller.clear();
                      });
                },
                iconColor: Colors.yellow,
                icon: Icons.edit_outlined,
                text: 'Change note name',
              ),
              const SizedBox(
                height: 10,
              ),
              ButtonInBottomSheet(
                backgroundColor: const Color.fromARGB(255, 15, 68, 17),
                onTap: () {
                  context
                      .read<AddVoiceNoteBloc>()
                      .add(AddNoteEvent(context: context));
                },
                iconColor: const Color.fromARGB(255, 81, 255, 87),
                icon: Icons.save,
                text: 'Save note',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChangeDescriptionWidget extends StatelessWidget {
  const ChangeDescriptionWidget({
    Key? key,
    required this.addTodoController,
    required this.utilities,
    required this.formKey,
    //required this.description,
  }) : super(key: key);
  final TextEditingController addTodoController;
  final Utilities utilities;
  final GlobalKey<FormState> formKey;
  // final String description;

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
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AddVoiceNoteBloc>().add(
                            ChangeDescriptionEvent(
                                context: context,
                                description: addTodoController.text));
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
