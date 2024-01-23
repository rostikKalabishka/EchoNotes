import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:note_app/ui/widgets/widget.dart';

@RoutePage()
class ListNotesPage extends StatefulWidget {
  const ListNotesPage({Key? key}) : super(key: key);

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
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                int taskCount = index * 5;
                String date = '17.01.2024';

                return ClickedCardWidget(
                  onTap: () {},
                  cardInfo: CardInfoWidget(
                    taskCount: taskCount,
                    date: date,
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class ClickedCardWidget extends StatelessWidget {
  final VoidCallback onTap;
  final CardInfoWidget cardInfo;

  const ClickedCardWidget({
    Key? key,
    required this.onTap,
    required this.cardInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: cardInfo,
      ),
    );
  }
}

class CardInfoWidget extends StatelessWidget {
  final int taskCount;
  final String date;

  const CardInfoWidget({
    Key? key,
    required this.taskCount,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Container(
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(12),
        //         gradient: const LinearGradient(
        //           begin: Alignment.topRight,
        //           end: Alignment.bottomLeft,
        //           colors: [
        //             Colors.blue,
        //             Colors.green,
        //             Colors.red,
        //           ],
        //         ),
        //       ),
        //       child: Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 8),
        //         child: Text('$taskCount %'),
        //       ),
        //     ),
        //     const Text('Notes'),
        //     Row(
        //       children: [
        //         const Icon(
        //           Icons.calendar_month,
        //         ),
        //         Text(date),
        //       ],
        //     ),
        //     Expanded(
        //       child: ListView.builder(
        //         shrinkWrap: true,
        //         physics: const NeverScrollableScrollPhysics(),
        //         itemCount: taskCount,
        //         itemBuilder: (context, index) {
        //           return ListTile(
        //             title: Text('Task $index'),
        //           );
        //         },
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
