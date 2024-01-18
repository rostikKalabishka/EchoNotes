import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:note_app/ui/widgets/widget.dart';

@RoutePage()
class ListNotesPage extends StatefulWidget {
  const ListNotesPage({super.key});

  @override
  State<ListNotesPage> createState() => _ListNotesPageState();
}

class _ListNotesPageState extends State<ListNotesPage> {
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
                  onTap: () {},
                  cardInfo: const CardInfoWidget(),
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.blue,
                      Colors.green,
                      Colors.red,
                    ],
                  )),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('0 %'),
              ),
            ),
            const Text('Notes'),
            const Row(
              children: [
                Icon(
                  Icons.calendar_month,
                ),
                Text('17.01.2024'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
