import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:unicons/unicons.dart';
import 'package:myapp/screens/IndividualScreen.dart';
import 'package:myapp/screens/PrincipleScreen.dart';
import 'package:myapp/screens/TrendingScreen.dart';
import 'package:myapp/screens/ETFScreen.dart';


class TabNavigations{
  final Widget page;
  final Widget title;
  final Icon icon;

  TabNavigations({required this.page, required this.title, required this.icon});

  static List<TabNavigations> get items=>[
    TabNavigations(page: TrendingScreen(), title: "Trending", icon: Icon(UniconsLine.fire)),
    TabNavigations(page: PrincipleScreen(), title: "Principles", icon: Icon(UniconsLine.lightbulb)),
    TabNavigations(page: ETFScreen(), title: "ETF", icon: Icon(UniconsLine.archive)),
    TabNavigations(page: IndividualScreen(), title: "Individual", icon: Icon(UniconsLine.analysis))
  ];
}