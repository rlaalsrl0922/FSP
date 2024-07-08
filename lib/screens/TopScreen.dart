import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TopScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar : AppBar(
        title: Row(
            children: [const Text('Top100 page')]
        )
    ), body: Center(child: Text('Top100 Page')),
        drawer: Drawer(
          child: ListView(
              padding: EdgeInsets.zero,
              children: [
          DrawerHeader(
          child: Text('Information'),
          decoration: BoxDecoration(
            color: Colors.deepPurple,
          ),
        ),
        ListTile(
          title: Text('My Page'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
        title: Text('Data Source'),
    onTap: () {
      Navigator.pop(context);
    })])));
  }
}