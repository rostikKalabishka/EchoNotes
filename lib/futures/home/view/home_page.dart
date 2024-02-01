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

  onBottomNavigationBarTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  final List<Widget> pages = [
    const NotesPage(),
    const ListTodoPage(),
    const AccountSettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      bottomNavigationBar: bottomNavigationBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: pages,
      ),
    );
  }

  bottomNavigationBar() {
    return GNav(
      gap: 8,
      onTabChange: onBottomNavigationBarTap,
      selectedIndex: _indexPage,
      tabs: const [
        GButton(
          icon: FontAwesomeIcons.noteSticky,
          text: 'Notes',
        ),
        GButton(
          icon: FontAwesomeIcons.listCheck,
          text: 'List',
        ),
        GButton(
          icon: FontAwesomeIcons.user,
          text: 'Account',
        )
      ],
    );
  }
}
