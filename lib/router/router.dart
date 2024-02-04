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

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
            page: HomeRoute.page,
            path: '/',
            initial: true,
            durationInMilliseconds: 0,
            children: [
              CustomRoute(
                  page: NotesRoute.page,
                  path: 'notes',
                  durationInMilliseconds: 0),
              CustomRoute(
                  page: ListTodoRoute.page,
                  path: 'list_todo',
                  durationInMilliseconds: 0),
              CustomRoute(
                  page: AccountSettingsRoute.page,
                  path: 'account_settings',
                  durationInMilliseconds: 0),
            ]),
        CustomRoute(
            page: NoteRoute.page,
            path: '/notes/note',
            durationInMilliseconds: 0),
        CustomRoute(
            page: AddNotesRoute.page,
            path: '/notes/add_notes',
            durationInMilliseconds: 0),
        CustomRoute(
            page: AddVoiceNoteRoute.page,
            path: '/notes/add_notes/add_voice_note',
            durationInMilliseconds: 0),
        CustomRoute(
            page: AddDefaultNotesRoute.page,
            path: '/notes/add_notes/add_default_note',
            durationInMilliseconds: 0),
        CustomRoute(
            page: AddListTodoRoute.page,
            path: '/list_todo/add_list_notes',
            durationInMilliseconds: 0),
        CustomRoute(
            page: CurrentTodoListInfoRoute.page,
            path: '/list_todo/current_todo_list_info_route',
            durationInMilliseconds: 0),
      ];
}
