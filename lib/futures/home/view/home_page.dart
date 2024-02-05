import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:note_app/futures/account_settings/view/account_settings.dart';

import 'package:note_app/futures/list_todo/view/list_notes.dart';

import 'package:note_app/futures/notes/view/notes.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _indexPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  onPageChanged(int indexPage) {
    setState(() {
      _indexPage = indexPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: const [
          NotesPage(),
          ListTodoPage(),
          AccountSettingsPage(),
        ],
      ),
      bottomNavigationBar: GNav(
        backgroundColor: theme.bottomNavigationBarTheme.backgroundColor ??
            theme.scaffoldBackgroundColor,
        gap: 8,
        onTabChange: (index) {
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
        },
        selectedIndex: _indexPage,
        tabs: const [
          GButton(
              icon: FontAwesomeIcons.noteSticky,
              text: 'Notes',
              textColor: Colors.white),
          GButton(
              icon: FontAwesomeIcons.listCheck,
              text: 'List',
              textColor: Colors.white),
          GButton(
              icon: FontAwesomeIcons.user,
              text: 'Account',
              textColor: Colors.white),
        ],
      ),
    );
  }
}
