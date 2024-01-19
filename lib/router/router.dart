import 'package:auto_route/auto_route.dart';
import 'package:note_app/futures/account_settings/view/account_settings.dart';
import 'package:note_app/futures/add_notes/view/add_notes.dart';
import 'package:note_app/futures/folder_list/view/list_folder.dart';
import 'package:note_app/futures/home/view/home_page.dart';
import 'package:note_app/futures/list_notes/view/list_notes.dart';
import 'package:note_app/futures/notes/view/notes.dart';
import 'package:note_app/futures/search/search.dart';
part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, path: '/', children: [
          AutoRoute(
            page: NotesRoute.page,
            path: 'notes',
          ),
          AutoRoute(
            page: ListNotesRoute.page,
            path: 'list_notes',
          ),
          AutoRoute(
            page: FolderListRoute.page,
            path: 'folder_list',
          ),
          AutoRoute(
            page: AccountSettingsRoute.page,
            path: 'account_settings',
          )
        ]),
        AutoRoute(
          page: AddNotesRoute.page,
          path: '/',
        )
      ];
}
