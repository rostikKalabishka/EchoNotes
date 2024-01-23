import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/ui/widgets/widget.dart';

@RoutePage()
class FolderListPage extends StatefulWidget {
  const FolderListPage({Key? key}) : super(key: key);

  @override
  State<FolderListPage> createState() => _FolderListPageState();
}

class _FolderListPageState extends State<FolderListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          showModalMenuBottomsSheet(context);
        },
        dataButton: const Icon(FontAwesomeIcons.plus),
      ),
      body: const CustomScrollView(
        slivers: [
          // const SliverAppBar(
          //   centerTitle: true,
          //   title: Text('EchoNotes'),
          // ),
          // SliverGrid.count(
          //   crossAxisCount: 2,
          //   children: List.generate(20, (index) {
          //     return Padding(
          //       padding:
          //           const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          //       child: ClickedCardWidget(
          //         cardInfo: const CardInfoWidget(),
          //         onTap: () {},
          //         colorsCard: Colors.green,
          //       ),
          //     );
          //   }),
          // ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('My Folder'),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          AspectRatio(
            aspectRatio: 4 / 1.85,
            child: Image.network(
                'https://cdn.pixabay.com/photo/2016/03/31/18/33/blue-1294461_640.png'),
          )
        ],
      ),
    );
  }
}

Future<void> showModalMenuBottomsSheet(BuildContext context) async {
  double screenHeight = MediaQuery.of(context).size.height;
  double modalHeight = screenHeight * 0.9;
  final TextEditingController folderNameController = TextEditingController();
  final List<Widget> images = List.generate(20, (index) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Image.network(
        'https://cdn.pixabay.com/photo/2016/03/31/18/33/blue-1294461_640.png',
        width: 120,
        height: 120,
      ),
    );
  });

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        height: modalHeight,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                const Text('Create folder'),
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
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: images,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                children: [
                  TextFormField(
                    controller: folderNameController,
                    decoration: const InputDecoration(
                      hintText: 'Name folder',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 40.0),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Save'),
                    ),
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
