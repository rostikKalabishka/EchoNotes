import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:note_app/futures/notes/view/notes.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _indexPage = 0;
  onPageChanged(int indexPage) {
    setState(() {
      _indexPage = indexPage;
    });
  }

  final List<Widget> pages = [
    const NotesPage(),
    Container(
      color: Colors.deepPurple,
    ),
    Container(
      color: Colors.deepOrange,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar(),
      body: IndexedStack(
        index: _indexPage,
        children: pages,
      ),
      // body: CustomScrollView(
      //   slivers: [
      //     SliverAppBar(
      //       centerTitle: true,
      //       actions: [
      //         IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
      //         IconButton(onPressed: () {}, icon: const Icon(Icons.add))
      //       ],
      //       title: const Text('EchoNotes '),
      //     ),
      //     // SliverToBoxAdapter(child: ,)
      //   ],
    );
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      onTap: onPageChanged,
      unselectedItemColor: Colors.black,
      currentIndex: _indexPage,
      selectedItemColor: Colors.blue[800],
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.notes), label: 'Notes'),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
        BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'Folder'),
      ],
    );
  }
}
