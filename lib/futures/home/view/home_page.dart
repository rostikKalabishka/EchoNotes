import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:note_app/futures/account_settings/view/account_settings.dart';
import 'package:note_app/futures/folder_list/view/list_folder.dart';
import 'package:note_app/futures/list_notes/view/list_notes.dart';
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
    const ListNotesPage(),
    const FolderListPage(),
    const AccountSettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: pages,
      ),
    );
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      onTap: onBottomNavigationBarTap,
      unselectedItemColor: Colors.black,
      currentIndex: _indexPage,
      selectedItemColor: Colors.blue[800],
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.notes), label: 'Notes'),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
        BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'Folder'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_box), label: 'Account'),
      ],
    );
  }
}
