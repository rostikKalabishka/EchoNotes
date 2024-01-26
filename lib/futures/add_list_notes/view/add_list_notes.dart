import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/futures/note/widgets/custom_button_widget.dart';
import 'package:note_app/ui/widgets/widget.dart';

@RoutePage()
class AddListNotesPage extends StatefulWidget {
  const AddListNotesPage({super.key});

  @override
  State<AddListNotesPage> createState() => _AddListNotesPageState();
}

class _AddListNotesPageState extends State<AddListNotesPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    Size size = MediaQuery.of(context).size;
    double modalHeight = size.height * 0.4;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFloatingActionButton(
        height: size.height * 0.075,
        width: size.height * 0.075,
        borderRadius: BorderRadius.circular(12),
        onPressed: () {},
        dataButton: const Icon(FontAwesomeIcons.plus),
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                title: const Text('Note'),
                actions: [
                  IconButton(
                    onPressed: () {
                      showModalMenuBottomSheet(
                          context: context,
                          modalHeight: modalHeight,
                          child: const ChangeFolder());
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
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      //add image

                      Lottie.asset('assets/lottie/voice.json', fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                        print(error);
                        return Text('$error');
                      }),
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
                  CustomButtonWidget(
                    theme: theme,
                    size: size,
                    onTap: () {},
                    child: Text(
                      'UA',
                      style: theme.textTheme.labelMedium,
                    ),
                  ),
                  CustomButtonWidget(
                    theme: theme,
                    size: size,
                    onTap: () {
                      //   context.read<NotePageBloc>().add(ImagePickerEvent());
                    },
                    child: const Icon(Icons.attachment),
                  ),
                ],
              ),
            ),
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
                backgroundColor: const Color.fromARGB(187, 191, 179, 4),
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
