// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AccountSettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AccountSettingsPage(),
      );
    },
    AddDefaultNotesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AddDefaultNotesPage(),
      );
    },
    AddListTodoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AddListTodoPage(),
      );
    },
    AddNotesRoute.name: (routeData) {
      final args = routeData.argsAs<AddNotesRouteArgs>(
          orElse: () => const AddNotesRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddNotesPage(key: args.key),
      );
    },
    AddVoiceNoteRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AddVoiceNotePage(),
      );
    },
    CurrentTodoListInfoRoute.name: (routeData) {
      final args = routeData.argsAs<CurrentTodoListInfoRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CurrentTodoListInfoPage(
          key: args.key,
          todoList: args.todoList,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    ListTodoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ListTodoPage(),
      );
    },
    NoteRoute.name: (routeData) {
      final args = routeData.argsAs<NoteRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NotePage(
          key: args.key,
          note: args.note,
        ),
      );
    },
    NotesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NotesPage(),
      );
    },
    SearchRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SearchPage(),
      );
    },
  };
}

/// generated route for
/// [AccountSettingsPage]
class AccountSettingsRoute extends PageRouteInfo<void> {
  const AccountSettingsRoute({List<PageRouteInfo>? children})
      : super(
          AccountSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountSettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AddDefaultNotesPage]
class AddDefaultNotesRoute extends PageRouteInfo<void> {
  const AddDefaultNotesRoute({List<PageRouteInfo>? children})
      : super(
          AddDefaultNotesRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddDefaultNotesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AddListTodoPage]
class AddListTodoRoute extends PageRouteInfo<void> {
  const AddListTodoRoute({List<PageRouteInfo>? children})
      : super(
          AddListTodoRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddListTodoRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AddNotesPage]
class AddNotesRoute extends PageRouteInfo<AddNotesRouteArgs> {
  AddNotesRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AddNotesRoute.name,
          args: AddNotesRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'AddNotesRoute';

  static const PageInfo<AddNotesRouteArgs> page =
      PageInfo<AddNotesRouteArgs>(name);
}

class AddNotesRouteArgs {
  const AddNotesRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'AddNotesRouteArgs{key: $key}';
  }
}

/// generated route for
/// [AddVoiceNotePage]
class AddVoiceNoteRoute extends PageRouteInfo<void> {
  const AddVoiceNoteRoute({List<PageRouteInfo>? children})
      : super(
          AddVoiceNoteRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddVoiceNoteRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CurrentTodoListInfoPage]
class CurrentTodoListInfoRoute
    extends PageRouteInfo<CurrentTodoListInfoRouteArgs> {
  CurrentTodoListInfoRoute({
    Key? key,
    required TodoList todoList,
    List<PageRouteInfo>? children,
  }) : super(
          CurrentTodoListInfoRoute.name,
          args: CurrentTodoListInfoRouteArgs(
            key: key,
            todoList: todoList,
          ),
          initialChildren: children,
        );

  static const String name = 'CurrentTodoListInfoRoute';

  static const PageInfo<CurrentTodoListInfoRouteArgs> page =
      PageInfo<CurrentTodoListInfoRouteArgs>(name);
}

class CurrentTodoListInfoRouteArgs {
  const CurrentTodoListInfoRouteArgs({
    this.key,
    required this.todoList,
  });

  final Key? key;

  final TodoList todoList;

  @override
  String toString() {
    return 'CurrentTodoListInfoRouteArgs{key: $key, todoList: $todoList}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ListTodoPage]
class ListTodoRoute extends PageRouteInfo<void> {
  const ListTodoRoute({List<PageRouteInfo>? children})
      : super(
          ListTodoRoute.name,
          initialChildren: children,
        );

  static const String name = 'ListTodoRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NotePage]
class NoteRoute extends PageRouteInfo<NoteRouteArgs> {
  NoteRoute({
    Key? key,
    required Note note,
    List<PageRouteInfo>? children,
  }) : super(
          NoteRoute.name,
          args: NoteRouteArgs(
            key: key,
            note: note,
          ),
          initialChildren: children,
        );

  static const String name = 'NoteRoute';

  static const PageInfo<NoteRouteArgs> page = PageInfo<NoteRouteArgs>(name);
}

class NoteRouteArgs {
  const NoteRouteArgs({
    this.key,
    required this.note,
  });

  final Key? key;

  final Note note;

  @override
  String toString() {
    return 'NoteRouteArgs{key: $key, note: $note}';
  }
}

/// generated route for
/// [NotesPage]
class NotesRoute extends PageRouteInfo<void> {
  const NotesRoute({List<PageRouteInfo>? children})
      : super(
          NotesRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SearchPage]
class SearchRoute extends PageRouteInfo<void> {
  const SearchRoute({List<PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
