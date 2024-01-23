import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/futures/note/bloc/note_page_bloc.dart';
import 'package:note_app/futures/note/widgets/custom_button_widget.dart';
import 'package:note_app/repository/model/model.dart';

import 'package:note_app/ui/widgets/widget.dart';

@RoutePage()
class NotePage extends StatefulWidget {
  const NotePage({Key? key, required this.note}) : super(key: key);
  final Note note;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<NotePageBloc, NotePageState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: CustomFloatingActionButton(
            onPressed: () {
              showModalMenuBottomsSheet(context);
            },
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
                          showModalMenuBottomsSheet(context);
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
                            cardColor: theme.cardColor,
                            cardInfo: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CustomBoxShadowContainer(
                                        width: 60,
                                        height: 60,
                                        cardInfo:
                                            const Icon(FontAwesomeIcons.play),
                                        cardColor: theme.cardColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '0:00:08',
                                      style: theme.textTheme.labelLarge,
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Text(
                                    'bibiabibibbboasdasdazsd saddas ddas',
                                    style: theme.textTheme.labelLarge,
                                  ),
                                )
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height * 0.05,
                          // ),
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
                                        child:
                                            Image.asset(state.selectedImage)),
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
                          'UA',
                          style: theme.textTheme.labelMedium,
                        ),
                      ),
                      CustomButtonWidget(
                        theme: theme,
                        size: size,
                        onTap: () {
                          context.read<NotePageBloc>().add(ImagePickerEvent());
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

  Future showModalMenuBottomsSheet(BuildContext context) async {
    final theme = Theme.of(context);
    return showModalBottomSheet(
      backgroundColor: theme.dialogBackgroundColor,
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    ButtonInBottomSheet(
                      backgroundColor: const Color.fromARGB(255, 156, 77, 77),
                      onTap: () {},
                      iconColor: Colors.red,
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
          ),
        );
      },
    );
  }
}
