import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/tab/tab_action.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:myapp/home_page.dart';
import 'package:myapp/login_page.dart';
import 'package:myapp/signup_page.dart';
import 'package:myapp/tab/bottom_tabs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme : theme(),
      initialRoute: "/login",
      routes: {
        "/login": (context) => LoginPage(),
        "/signup": (context) => SignupPage(),
        "/home" : (context) => TabActions(selectedIndex: 0)
      },
    );
  }
}

