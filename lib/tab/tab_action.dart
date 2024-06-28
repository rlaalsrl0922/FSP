import 'package:flutter/material.dart';
import 'package:myapp/tab/bottom_tabs.dart';
import 'package:unicons/unicons.dart';



class TabActions extends StatefulWidget {
  int selectedIndex = 0;
  TabActions({required this.selectedIndex});

  @override
  _TabsActionsPageState createState() => _TabsActionsPageState();
}

class _TabsActionsPageState extends State<TabActions> {
  int _selectedIndex = 0;
  late String _email;
  late String _route;

  // bottom navigation 눌렸을 때
  void _ItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
      _selectedIndex = widget.selectedIndex;
      print(_selectedIndex);
    });
  }

  @override
  void initState() {
    super.initState();
    _ItemTapped(widget.selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.selectedIndex,
        children: [
          for (final Item in TabNavigations.items) Item.page,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(UniconsLine.fire), label: 'Trending'),
          BottomNavigationBarItem(
              icon: Icon(UniconsLine.lightbulb), label: 'Principle'),
          BottomNavigationBarItem(
              icon: Icon(UniconsLine.archive), label: 'ETF'),
          BottomNavigationBarItem(
              icon:Icon( UniconsLine.analysis), label: 'Individual'),
        ],
        currentIndex: _selectedIndex,
        onTap: _ItemTapped,
      ),
    );
  }
}