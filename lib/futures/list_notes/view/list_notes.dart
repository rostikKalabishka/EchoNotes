import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        dataButton: const Icon(FontAwesomeIcons.plus),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            centerTitle: true,
            title: Text('EchoNotes'),
          ),
          SliverGrid(
            gridDelegate: MySliverGridDelegateWithMaxCrossAxisExtent(),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                int taskCount = (index + 1) * 2;
                String date = '17.01.2024';

                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ClickedCardWidget(
                    onTap: () {},
                    cardInfo: CardInfoWidget(
                      taskCount: taskCount,
                      date: date,
                    ),
                  ),
                );
              },
              childCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}

class MySliverGridDelegateWithMaxCrossAxisExtent
    extends SliverGridDelegateWithFixedCrossAxisCount {
  MySliverGridDelegateWithMaxCrossAxisExtent()
      : super(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.2,
        );

  @override
  bool shouldRelayout(covariant SliverGridDelegate oldDelegate) {
    return false;
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

class CardInfoWidget extends StatefulWidget {
  final int taskCount;
  final String date;

  const CardInfoWidget({
    Key? key,
    required this.taskCount,
    required this.date,
  }) : super(key: key);

  @override
  State<CardInfoWidget> createState() => _CardInfoWidgetState();
}

class _CardInfoWidgetState extends State<CardInfoWidget> {
  List<bool> taskCheckList = [];

  @override
  void initState() {
    super.initState();
    taskCheckList = List.generate(widget.taskCount, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.deepPurple,
                        Colors.pink,
                        Colors.pinkAccent,
                        Colors.purple
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '${widget.taskCount} %',
                      style: theme.textTheme.labelMedium,
                    ),
                  ),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
              ],
            ),

            Text(
              'List name',
              style: theme.textTheme.labelLarge,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: size.width * 0.01,
            ),
            Row(
              children: [
                const Icon(
                  FontAwesomeIcons.calendar,
                ),
                SizedBox(
                  width: size.width * 0.025,
                ),
                Text(widget.date, style: theme.textTheme.labelSmall),
              ],
            ),
            SizedBox(
              height: size.width * 0.01,
            ),
            // if (widget.taskCount > 0) // Check if there are tasks
            //   Expanded(
            //     child: ListView.builder(
            //       itemCount: widget.taskCount,
            //       itemBuilder: (context, index) {
            //         return CheckboxListTile(
            //           title: Text(
            //             'Task $index',
            //             style: theme.textTheme.labelSmall,
            //           ),
            //           value: taskCheckList[index],
            //           onChanged: (bool? value) {
            //             setState(() {
            //               taskCheckList[index] = value!;
            //             });
            //           },
            //         );
            //       },
            //     ),
            //   ),
            // if (widget.taskCount == 0)
            //   Text(
            //     'No tasks available',
            //     style: theme.textTheme.labelSmall,
            //   ),
          ],
        ),
      ),
    );
  }
}
