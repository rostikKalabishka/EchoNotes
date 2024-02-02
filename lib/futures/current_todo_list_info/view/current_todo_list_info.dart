// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import 'package:note_app/futures/current_todo_list_info/bloc/current_todo_list_info_bloc.dart';
import 'package:note_app/repository/model/todo_list.dart';
import 'package:note_app/ui/widgets/widget.dart';
import 'package:note_app/utilities/utilities.dart';

@RoutePage()
class CurrentTodoListInfoPage extends StatefulWidget {
  const CurrentTodoListInfoPage({super.key, required this.todoList});
  final TodoList todoList;
  @override
  State<CurrentTodoListInfoPage> createState() => _CurrentTodoListInfoState();
}

class _CurrentTodoListInfoState extends State<CurrentTodoListInfoPage> {
  final TextEditingController addTodoController = TextEditingController();
  final Utilities utilities = Utilities();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController changeNameController = TextEditingController();

  @override
  void initState() {
    context
        .read<CurrentTodoListInfoBloc>()
        .add(LoadTodoListEvent(todoList: widget.todoList));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Size size = MediaQuery.of(context).size;
    final double modalHeight = size.height * 0.4;
    final double modalAddTodoHeight = size.height * 0.8;
    return BlocBuilder<CurrentTodoListInfoBloc, CurrentTodoListInfoState>(
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
                    indexTodoList: widget.todoList.id!,
                    addTodoController: addTodoController,
                    utilities: utilities,
                    formKey: _formKey,
                    todoList: widget.todoList,
                  ));
            },
            dataButton: const Icon(FontAwesomeIcons.plus),
          ),
          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text(state.name),
                    actions: [
                      IconButton(
                        onPressed: () {
                          showModalMenuBottomSheet(
                              context: context,
                              modalHeight: modalHeight,
                              child: ChangeFolder(
                                todoListName: state.name,
                                todoList: widget.todoList,
                                utilities: utilities,
                                controller: changeNameController,
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
                              log('$error');
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
                                  cardInfo: Slidable(
                                    endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (_) {
                                              context
                                                  .read<
                                                      CurrentTodoListInfoBloc>()
                                                  .add(DeleteTodoEvent(
                                                      context: context,
                                                      index: index,
                                                      todo: todo));
                                            },
                                            backgroundColor:
                                                const Color(0xFFFE4A49),
                                            foregroundColor: Colors.white,
                                            icon: Icons.delete,
                                            spacing: 2,
                                            // label: 'Delete',
                                          ),
                                        ]),
                                    child: ListTile(
                                      title: Text(todo.name),
                                      leading: Checkbox(
                                        value: todo.isDone,
                                        onChanged: (bool? value) {
                                          context
                                              .read<CurrentTodoListInfoBloc>()
                                              .add(CheckboxTodoEvent(
                                                  value: value ?? false,
                                                  todo: todo,
                                                  todoIndex: index,
                                                  todoList: widget.todoList));
                                        },
                                      ),
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
    required this.indexTodoList,
    required this.todoList,
  }) : super(key: key);
  final TextEditingController addTodoController;
  final Utilities utilities;
  final GlobalKey<FormState> formKey;
  final int indexTodoList;
  final TodoList todoList;
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<CurrentTodoListInfoBloc>().add(
                              CreateNewTodoEvent(
                                  id: indexTodoList,
                                  name: addTodoController.text,
                                  context: context,
                                  todoList: todoList));
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
      required this.todoList,
      required this.utilities,
      required this.controller});
  final String todoListName;
  final TodoList todoList;
  final Utilities utilities;
  final TextEditingController controller;

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
                        state: CurrentTodoListInfoBloc,
                        controller: controller,
                        saveName: () {
                          context.read<CurrentTodoListInfoBloc>().add(
                              ChangeNameCurrentTodoListEvent(
                                  name: controller.text, todoList: todoList));
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
                  backgroundColor: const Color.fromARGB(255, 156, 77, 77),
                  onTap: () {
                    context.read<CurrentTodoListInfoBloc>().add(
                        DeleteCurrentTodoListEvent(
                            context: context, todo: todoList));
                  },
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
  }
}
