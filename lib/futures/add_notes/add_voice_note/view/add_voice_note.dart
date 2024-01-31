import 'package:auto_route/auto_route.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'package:note_app/futures/add_notes/add_voice_note/bloc/add_voice_note_bloc.dart';
import 'package:note_app/futures/note/widgets/custom_button_widget.dart';

import 'package:note_app/ui/widgets/widget.dart';

@RoutePage()
class AddVoiceNotePage extends StatefulWidget {
  const AddVoiceNotePage({super.key});

  @override
  State<AddVoiceNotePage> createState() => _AddVoiceNotePageState();
}

class _AddVoiceNotePageState extends State<AddVoiceNotePage> {
  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    Size size = MediaQuery.of(context).size;
    double modalHeight = size.height * 0.5;
    final theme = Theme.of(context);

    return BlocBuilder<AddVoiceNoteBloc, AddVoiceNoteState>(
      builder: (context, state) {
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
                  ? Icons.mic_outlined
                  : Icons.mic_off_outlined),
            ),
          ),
          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: const Text('Note'),
                    actions: [
                      IconButton(
                        onPressed: () {
                          showModalMenuBottomSheet(
                              context: context,
                              modalHeight: modalHeight,
                              child: const MenuWidget());
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
                          //add image

                          state.description.isEmpty
                              ? Lottie.asset('assets/lottie/voice.json',
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) {
                                  print(error);
                                  return Text('$error');
                                })
                              : CustomBoxShadowContainer(
                                  cardInfo: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomBoxShadowContainer(
                                              width: 50,
                                              height: 50,
                                              cardInfo:
                                                  const Icon(Icons.play_arrow),
                                              cardColor: theme.cardColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text('0:00:08')
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text(
                                          state.description,
                                        ),
                                      )
                                    ],
                                  ),
                                  cardColor: theme.cardColor,
                                ),

                          // state.selectedImage.isNotEmpty
                          //     ? Padding(
                          //         padding:
                          //             const EdgeInsets.symmetric(vertical: 20),
                          //         child: Container(
                          //           constraints: BoxConstraints(
                          //             maxHeight:
                          //                 MediaQuery.of(context).size.height *
                          //                     0.54,
                          //           ),
                          //           child: ClipRRect(
                          //               borderRadius: BorderRadius.circular(20),
                          //               child:
                          //                   Image.asset(state.selectedImage)),
                          //         ),
                          //       )
                          //     : const SizedBox.shrink()
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
                          'UA',
                          style: theme.textTheme.labelMedium,
                        ),
                      ),
                      CustomButtonWidget(
                        theme: theme,
                        size: size,
                        onTap: () {
                          //   context.read<NotePageBloc>().add(ImagePickerEvent());
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
  });

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
                onTap: () {},
                iconColor: Colors.yellow,
                icon: Icons.edit_outlined,
                text: 'Change note name',
              ),
              const SizedBox(
                height: 10,
              ),
              ButtonInBottomSheet(
                backgroundColor: const Color.fromARGB(255, 156, 77, 77),
                onTap: () {},
                iconColor: Colors.red,
                icon: Icons.folder_outlined,
                text: 'Add to folder',
              ),
              const SizedBox(
                height: 10,
              ),
              ButtonInBottomSheet(
                backgroundColor: const Color.fromARGB(255, 156, 77, 77),
                onTap: () {},
                iconColor: Colors.red,
                icon: Icons.change_circle_outlined,
                text: 'Delete note',
              ),
              const SizedBox(
                height: 10,
              ),
              ButtonInBottomSheet(
                backgroundColor: const Color.fromARGB(255, 156, 77, 77),
                onTap: () {},
                iconColor: Colors.red,
                icon: Icons.save,
                text: 'Save change',
              ),
              const SizedBox(
                height: 10,
              ),
              ButtonInBottomSheet(
                backgroundColor: const Color.fromARGB(255, 156, 77, 77),
                onTap: () {},
                iconColor: Colors.red,
                icon: Icons.delete_outline,
                text: 'Delete note',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
