import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:note_app/ui/widgets/widget.dart';

@RoutePage()
class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
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
            children: List.generate(20, (index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ClickedCardWidget(
                  cardInfo: const CardInfoWidget(),
                  onTap: () {},
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class CardInfoWidget extends StatelessWidget {
  const CardInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Notes'),
          Text('empty'),
          Row(
            children: [
              Icon(
                Icons.calendar_month,
              ),
              Text('17.01.2024'),
            ],
          ),
        ],
      ),
    );
  }
}
