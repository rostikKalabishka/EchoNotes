import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/futures/add_notes/bloc/add_notes_bloc.dart';
import 'package:note_app/ui/widgets/widget.dart';

@RoutePage()
class AddNotesPage extends StatelessWidget {
  AddNotesPage({super.key});
  final addNotesPageBloc = AddNotesPageBloc();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNotesPageBloc, AddNotesState>(
      bloc: addNotesPageBloc,
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text('Add Notes'),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomBoxShadowContainer(
                      cardColor: Colors.amber,
                      cardInfo: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ButtonOptionCreateNote(
                              textButton: 'Add default note',
                              buttonIcon: Icons.notes,
                              onPressed: () {
                                addNotesPageBloc.add(
                                    NavigateToAddNotePage(context: context));
                              },
                            ),
                            ButtonOptionCreateNote(
                              textButton: 'Add voice note',
                              buttonIcon: Icons.mic,
                              onPressed: () {
                                addNotesPageBloc.add(NavigateToAddVoiceNotePage(
                                    context: context));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
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

class ButtonOptionCreateNote extends StatelessWidget {
  const ButtonOptionCreateNote({
    super.key,
    required this.textButton,
    required this.buttonIcon,
    required this.onPressed,
  });

  final String textButton;
  final IconData buttonIcon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(buttonIcon),
          const SizedBox(
            width: 15,
          ),
          Text(textButton)
        ],
      ),
    );
  }
}
