import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/futures/notes/bloc/notes_bloc.dart';
import 'package:note_app/ui/widgets/widget.dart';

@RoutePage()
class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  void initState() {
    context.read<NotesBloc>().add(LoadNotesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<NotesBloc, NotesState>(
      listener: (context, state) {
        if (state.isLoading) {
          context.read<NotesBloc>().add(LoadNotesEvent());
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          floatingActionButton: CustomFloatingActionButton(
            onPressed: () {
              context.read<NotesBloc>().add(OpenAddPage(context: context));
            },
            dataButton: const Icon(FontAwesomeIcons.plus),
            heroTag: 'add_notes',
          ),
          body: CustomScrollView(
            slivers: [
              const SliverAppBar(
                centerTitle: true,
                title: Text('EchoNotes'),
              ),
              SliverGrid.count(
                crossAxisCount: 2,
                children: List.generate(state.noteList.length, (index) {
                  final notes = state.noteList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: ClickedCardWidget(
                      colorsCard: theme.cardColor,
                      cardInfo: CardInfoWidget(
                          name: notes.name,
                          description: notes.description,
                          dateTime: notes.createDate.toString()),
                      onTap: () {
                        context
                            .read<NotesBloc>()
                            .add(OpenNotesEvent(context: context, note: notes));
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CardInfoWidget extends StatelessWidget {
  const CardInfoWidget({
    super.key,
    required this.name,
    required this.description,
    required this.dateTime,
  });
  final String name;
  final String description;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name.isNotEmpty ? name : 'Note',
            style: theme.textTheme.labelLarge,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            description,
            style: theme.textTheme.labelMedium,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              const Icon(FontAwesomeIcons.calendar),
              SizedBox(
                width: size.width * 0.025,
              ),
              Text(
                dateTime,
                style: theme.textTheme.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
