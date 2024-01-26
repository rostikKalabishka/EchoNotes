import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/futures/list_todo/bloc/list_todo_bloc.dart';
import 'package:note_app/repository/model/todo_list.dart';

import 'package:note_app/ui/widgets/widget.dart';

@RoutePage()
class ListTodoPage extends StatefulWidget {
  const ListTodoPage({Key? key}) : super(key: key);

  @override
  State<ListTodoPage> createState() => _ListTodoPageState();
}

class _ListTodoPageState extends State<ListTodoPage> {
  @override
  void initState() {
    context.read<ListTodoBloc>().add(LoadTodoListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListTodoBloc, ListTodoState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: CustomFloatingActionButton(
            onPressed: () {
              context
                  .read<ListTodoBloc>()
                  .add(NavigateToAddTodoNotesEvent(context: context));
            },
            dataButton: const Icon(FontAwesomeIcons.plus),
          ),
          body: CustomScrollView(
            slivers: [
              const SliverAppBar(
                centerTitle: true,
                title: Text('EchoNotes'),
              ),
              state.todoList.isNotEmpty
                  ? SliverGrid(
                      gridDelegate:
                          MySliverGridDelegateWithMaxCrossAxisExtent(),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final todoList = state.todoList[index];

                          return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ClickedCardWidget(
                              onTap: () {},
                              cardInfo: CardInfoWidget(
                                todoList: todoList,
                              ),
                            ),
                          );
                        },
                        childCount: 5,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        );
      },
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

class CardInfoWidget extends StatelessWidget {
  final TodoList todoList;

  const CardInfoWidget({
    Key? key,
    required this.todoList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    final double modalHeight = size.height * 0.4;

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
                      '${todoList.percentage} %',
                      style: theme.textTheme.labelMedium,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showModalMenuBottomSheet(
                          context: context,
                          modalHeight: modalHeight,
                          child: const ChangeFolder());
                    },
                    icon: const Icon(Icons.more_vert))
              ],
            ),

            Text(
              todoList.name,
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
                Text(todoList.createDate, style: theme.textTheme.labelSmall),
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

class ChangeFolder extends StatelessWidget {
  const ChangeFolder({super.key});

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
                backgroundColor: Color.fromARGB(187, 191, 179, 4),
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
