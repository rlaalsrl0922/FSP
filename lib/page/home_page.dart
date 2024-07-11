import 'package:flutter/material.dart';
import 'package:myapp/screens/BookmarkScreen.dart';
import 'package:myapp/screens/TopScreen.dart';
import 'package:unicons/unicons.dart';
import 'package:myapp/screens/IndividualScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/tab/LeftDrawer.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key:key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [BookmarkScreen(), TopScreen()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(UniconsLine.star),
            label: 'Star',
          ),
          BottomNavigationBarItem(
            icon: Icon(UniconsLine.list_ul),
            label: 'Top100',
          ),
        ],
      ),
      drawer: LeftDrawer(),
    );
  }
}

AppBarTheme appBarTheme(){
  return AppBarTheme(
    centerTitle: false,
    color:Colors.deepPurple,
    elevation:0.0,
    iconTheme: IconThemeData(color:Colors.black),
      titleTextStyle: GoogleFonts.nanumGothic(
      fontSize:16,
      fontWeight:FontWeight.bold,
      color: Colors.black,
    )
  );
}

BottomNavigationBarThemeData bottomNavigationBarTheme(){
  return const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.black12,
    showUnselectedLabels: true,
  );
}

ElevatedButtonThemeData elevatedButtonTheme() {
  return ElevatedButtonThemeData(
      style : ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.5),
  )
  )
  );
}

ThemeData theme(){
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme(),
    bottomNavigationBarTheme: bottomNavigationBarTheme(),
    primarySwatch: Colors.deepPurple,
  );
}