import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookmarkScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar : AppBar(
        title: Row(
            children: [const Text('Bookmark page')]
        )
    ),body: SafeArea(
    top: true,
    child: Column(
    mainAxisSize: MainAxisSize.max,
    children: [
    Expanded(
    child: SingleChildScrollView(
    child: Column(
    mainAxisSize: MainAxisSize.max,
    children: [
    Padding(
    padding: EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
    child: Row(
    mainAxisSize: MainAxisSize.max,
    children: [
    Text('Stock Price ',
    style: TextStyle(
    fontSize: 20,
    color: Colors.black)
    ),
    Padding(
    padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
    child: Text('Stock change(+) (Stock change(%))'),
    ),
    ],
    ),
    ),
    Padding(
    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
    child: Row(
    mainAxisSize: MainAxisSize.max,
    children: [
    Container(
    width: 350,
    height: 200,
    child: Text("BookMarkScreen"),
    ),
    ],
    ),
    ),
    ],
    ),
    ))])));
  }
}