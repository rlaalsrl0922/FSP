import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/screens/LeftDrawer.dart';
import 'package:myapp/screens/NewsScreen.dart';

class BookmarkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Row(children: [const Text('Bookmark page')])),
        body: SafeArea(
            top: true,
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 350,
                      height: 30,
                      child: Text("BookMark Screen"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 20, 0, 0),
                  child: CompanyNewsScreen(),
                ),
              )
            ])),
        drawer: LeftDrawer(),
    );
  }
}
