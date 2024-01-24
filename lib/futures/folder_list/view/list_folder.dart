import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/ui/widgets/widget.dart';
import 'package:note_app/utilities/utilities.dart';

@RoutePage()
class FolderListPage extends StatefulWidget {
  const FolderListPage({Key? key}) : super(key: key);

  @override
  State<FolderListPage> createState() => _FolderListPageState();
}

class _FolderListPageState extends State<FolderListPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double modalHeight = screenHeight * 0.9;
    final Utilities utilities = Utilities();
    final _formKey = GlobalKey<FormState>();
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
    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          showModalMenuBottomSheet(
            child: CreateFolderWidget(
              folderNameController: folderNameController,
              formKey: _formKey,
              images: images,
              utilities: utilities,
            ),
            context: context,
            modalHeight: modalHeight,
          );
        },
        dataButton: const Icon(FontAwesomeIcons.plus),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            centerTitle: true,
            title: Text('EchoNotes'),
          ),
          SliverGrid.count(
            crossAxisCount: 2,
            children: List.generate(9, (index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {},
                  child: CustomBoxShadowContainer(
                    cardInfo: CardInfoWidget(
                      screenHeight: screenHeight,
                    ),
                    cardColor: theme.cardColor,
                  ),
                ),
              );
            }),
          ),
        ],
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
                backgroundColor: const Color.fromARGB(255, 156, 77, 77),
                onTap: () {},
                iconColor: Colors.red,
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

class CardInfoWidget extends StatelessWidget {
  const CardInfoWidget({
    super.key,
    required this.screenHeight,
  });
  final double screenHeight;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'My Folder',
                  style: theme.textTheme.labelMedium,
                ),
              ),
              IconButton(
                onPressed: () {
                  showModalMenuBottomSheet(
                    context: context,
                    modalHeight: screenHeight * 0.4,
                    child: const ChangeFolder(),
                  );
                },
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

class CreateFolderWidget extends StatelessWidget {
  const CreateFolderWidget({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.images,
    required this.utilities,
    required this.folderNameController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  final List<Widget> images;
  final Utilities utilities;
  final TextEditingController folderNameController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
              ),
              Text(
                'Create folder',
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
                  validator: (val) => utilities.textFieldValidator(val!),
                  controller: folderNameController,
                  decoration: InputDecoration(
                    errorStyle: theme.inputDecorationTheme.errorStyle,
                    hintText: 'Name folder',
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      AutoRouter.of(context).pop();
                    }
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 40.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Save',
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
