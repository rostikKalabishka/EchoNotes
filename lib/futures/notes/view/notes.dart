import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: CustomFloatingActionButton(
            onPressed: () {},
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
                      cardInfo: CardInfoWidget(
                          name: notes.name,
                          description: notes.description,
                          dateTime: notes.createDate.toString()),
                      onTap: () {},
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
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name),
          Text(description),
          Row(
            children: [
              const Icon(
                Icons.calendar_month,
              ),
              Text(dateTime),
            ],
          ),
        ],
      ),
    );
  }
}
