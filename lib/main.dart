import 'package:flutter/material.dart';
import 'package:myapp/screens/IndividualScreen.dart';
import 'package:myapp/tab/tab_action.dart';
import 'package:myapp/page/home_page.dart';
import 'package:myapp/page/login_page.dart';
import 'package:myapp/page/signup_page.dart';
import 'package:myapp/domain/Fullstock.dart';
import 'package:myapp/domain/TopStock.dart';


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
        "/home" : (context) => TabActions(selectedIndex: 0),
        //"/individual" : (context) => IndividualScreen()
      },
    );
  }
}

