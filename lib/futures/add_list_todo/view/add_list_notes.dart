import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/futures/add_list_todo/bloc/add_list_notes_bloc.dart';

import 'package:note_app/core/ui/widgets/widget.dart';
import 'package:note_app/core/utilities/utilities.dart';

@RoutePage()
class AddListTodoPage extends StatefulWidget {
  const AddListTodoPage({super.key});

  @override
  State<AddListTodoPage> createState() => _AddListTodoPageState();
}

class _AddListTodoPageState extends State<AddListTodoPage> {
  final TextEditingController addTodoController = TextEditingController();
  final Utilities utilities = Utilities();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController addNameTodoListController =
      TextEditingController();
  @override
  void initState() {
    context.read<AddListTodoBloc>().add(LoadDefaultValue());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Size size = MediaQuery.of(context).size;
    final double modalHeight = size.height * 0.4;
    final double modalAddTodoHeight = size.height * 0.8;
    return BlocBuilder<AddListTodoBloc, AddListTodoState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: CustomFloatingActionButton(
            height: size.height * 0.075,
            width: size.height * 0.075,
            borderRadius: BorderRadius.circular(12),
            onPressed: () {
              showModalMenuBottomSheet(
                  context: context,
                  modalHeight: modalAddTodoHeight,
                  child: AddTodo(
                    addTodoController: addTodoController,
                    utilities: utilities,
                    formKey: _formKey,
                  ));
            },
            dataButton: const Icon(FontAwesomeIcons.plus),
            heroTag: 'add_list_notes',
          ),
          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text(state.todoListName),
                    actions: [
                      IconButton(
                        onPressed: () {
                          showModalMenuBottomSheet(
                              context: context,
                              modalHeight: modalHeight,
                              child: ChangeFolder(
                                todoListName: state.todoListName,
                                controller: addNameTodoListController,
                                utilities: utilities,
                              ));
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
                  state.todo.isEmpty
                      ? SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Lottie.asset('assets/lottie/voice.json',
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) {
                              return Text('$error');
                            }),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final todo = state.todo[index];
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: CustomBoxShadowContainer(
                                  cardColor: theme.cardColor,
                                  cardInfo: ListTile(
                                    title: Text(
                                      todo.name,
                                      style: theme.textTheme.labelMedium,
                                    ),
                                    leading: Checkbox(
                                      value: todo.isDone,
                                      onChanged: (bool? value) {
                                        context
                                            .read<AddListTodoBloc>()
                                            .add(CheckboxTodoEvent(
                                              value: value ?? false,
                                              todo: todo,
                                              todoIndex: index,
                                            ));
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount: state.todo.length,
                          ),
                        ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class AddTodo extends StatelessWidget {
  const AddTodo({
    Key? key,
    required this.addTodoController,
    required this.utilities,
    required this.formKey,
  }) : super(key: key);
  final TextEditingController addTodoController;
  final Utilities utilities;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
              ),
              Text(
                'Todo',
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
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    mixLines: 1,
                    validator: (value) => utilities.textFieldValidator(value!),
                    hintText: 'Add note name',
                    textEditorController: addTodoController,
                    maxLines: 15,
                    autofocus: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AddListTodoBloc>().add(
                                CreateTodoEvent(
                                    name: addTodoController.text,
                                    context: context),
                              );
                          addTodoController.clear();
                        }
                      },
                      child: Text(
                        'add todo',
                        style: theme.textTheme.labelLarge,
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ChangeFolder extends StatelessWidget {
  const ChangeFolder(
      {super.key,
      required this.todoListName,
      required this.controller,
      required this.utilities});
  final String todoListName;
  final TextEditingController controller;
  final Utilities utilities;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
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
                  onTap: () {
                    openDialog(
                        validator: (val) => utilities.textFieldValidator(val!),
                        context: context,
                        state: AddListTodoBloc,
                        controller: controller,
                        saveName: () {
                          context.read<AddListTodoBloc>().add(
                              SaveNameTodoListEvent(name: controller.text));
                        });
                  },
                  iconColor: Colors.yellow,
                  icon: Icons.edit_outlined,
                  text: 'Change note name',
                ),
                const SizedBox(
                  height: 10,
                ),
                ButtonInBottomSheet(
                  backgroundColor: const Color.fromARGB(255, 15, 68, 17),
                  onTap: () {
                    context.read<AddListTodoBloc>().add(CreateTodoListEvent(
                        name: todoListName, context: context));
                  },
                  iconColor: const Color.fromARGB(255, 81, 255, 87),
                  icon: Icons.save,
                  text: 'Save todo list',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
