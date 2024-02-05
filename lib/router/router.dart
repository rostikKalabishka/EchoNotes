import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:note_app/futures/account_settings/account_settings.dart';
import 'package:note_app/futures/add_list_todo/view/add_list_notes.dart';

import 'package:note_app/futures/add_notes/add_default_notes/add_default_notes.dart';
import 'package:note_app/futures/add_notes/add_notes.dart';
import 'package:note_app/futures/add_notes/add_voice_note/add_voice_note.dart';
import 'package:note_app/futures/current_todo_list_info/view/current_todo_list_info.dart';

import 'package:note_app/futures/home/home.dart';
import 'package:note_app/futures/list_todo/view/list_notes.dart';

import 'package:note_app/futures/note/note.dart';
import 'package:note_app/futures/notes/notes.dart';
import 'package:note_app/futures/search/view/search.dart';
import 'package:note_app/repository/model/note.dart';
import 'package:note_app/repository/model/todo_list.dart';

part 'router.gr.dart';

class AppRouterPath {
  static String homeRoutePath = '/';
  static String notesRoutePath = 'notes';
  static String listTodoRoutePath = 'list_todo';
  static String accountSettingsRoutePath = 'account_settings';
  static String noteRoutePath = '/notes/note';
  static String addNotesRoutePath = '/notes/add_notes';
  static String addVoiceNoteRoutePath = '/notes/add_notes/add_voice_note';
  static String addDefaultNotesRoutePath = '/notes/add_notes/add_default_note';
  static String addListTodoRoutePath = '/list_todo/add_list_notes';
  static String currentTodoListInfoRoutePath =
      '/list_todo/current_todo_list_info_route';
}

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
            page: HomeRoute.page,
            path: AppRouterPath.homeRoutePath,
            initial: true,
            durationInMilliseconds: 0,
            children: [
              CustomRoute(
                  page: NotesRoute.page,
                  path: AppRouterPath.notesRoutePath,
                  durationInMilliseconds: 0),
              CustomRoute(
                  page: ListTodoRoute.page,
                  path: AppRouterPath.listTodoRoutePath,
                  durationInMilliseconds: 0),
              CustomRoute(
                  page: AccountSettingsRoute.page,
                  path: AppRouterPath.accountSettingsRoutePath,
                  durationInMilliseconds: 0),
            ]),
        CustomRoute(
            page: NoteRoute.page,
            path: AppRouterPath.noteRoutePath,
            durationInMilliseconds: 0),
        CustomRoute(
            page: AddNotesRoute.page,
            path: AppRouterPath.addNotesRoutePath,
            durationInMilliseconds: 0),
        CustomRoute(
            page: AddVoiceNoteRoute.page,
            path: AppRouterPath.addVoiceNoteRoutePath,
            durationInMilliseconds: 0),
        CustomRoute(
            page: AddDefaultNotesRoute.page,
            path: AppRouterPath.addDefaultNotesRoutePath,
            durationInMilliseconds: 0),
        CustomRoute(
            page: AddListTodoRoute.page,
            path: AppRouterPath.addListTodoRoutePath,
            durationInMilliseconds: 0),
        CustomRoute(
            page: CurrentTodoListInfoRoute.page,
            path: AppRouterPath.currentTodoListInfoRoutePath,
            durationInMilliseconds: 0),
      ];
}
