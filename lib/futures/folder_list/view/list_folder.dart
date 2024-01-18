import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const Text('My Folder'),
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
