import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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

    return Scaffold(
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
              const SliverFillRemaining(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      CustomBoxShadowContainer(
                        cardInfo: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CustomBoxShadowContainer(
                                    width: 50,
                                    height: 50,
                                    cardInfo: Icon(Icons.play_arrow),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('0:00:08')
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'bibiabibibbboasdasdazsd saddasddas',
                              ),
                            )
                          ],
                        ),
                      ),
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
                  CustomBoxShadowContainer(
                    cardInfo: TextButton(
                      onPressed: () {},
                      child: const Text('UA'),
                    ),
                  ),
                  CustomBoxShadowContainer(
                    cardInfo: TextButton(
                      onPressed: () {
                        showModalMenuBottomsSheet(context);
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                  CustomBoxShadowContainer(
                    cardInfo: TextButton(
                      onPressed: () {},
                      child: const Icon(Icons.attachment),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future showModalMenuBottomsSheet(BuildContext context) async {
    return showModalBottomSheet(
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
                  const Text('Menu'),
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
                      icon: Icons.delete_outline,
                      text: 'Delete note',
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
