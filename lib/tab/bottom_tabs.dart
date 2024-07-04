import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:unicons/unicons.dart';
import 'package:myapp/screens/IndividualScreen.dart';
import 'package:myapp/screens/TopScreen.dart';
import 'package:myapp/screens/BookmarkScreen.dart';


class TabNavigations{
  final Widget page;
  final Widget title;
  final Icon icon;

  TabNavigations({required this.page, required this.title, required this.icon});

  static List<TabNavigations> get items=>[
    TabNavigations(page: BookmarkScreen(), title: Text("Trending"), icon: Icon(UniconsLine.star)),
    TabNavigations(page: IndividualScreen(), title: Text("Principles"), icon: Icon(UniconsLine.analysis)),
    TabNavigations(page: TopScreen(), title: Text("Individual"), icon: Icon(UniconsLine.list_ul))
  ];
}