import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/tab/LeftDrawer.dart';
import 'package:unicons/unicons.dart';
import 'package:myapp/widget/TopStockWidget.dart';

class TopScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar : AppBar(
        title: Row(
            children: [const Text('Top100 page')]
        )
    ), body: SafeArea(
        top: true,
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 350,
                  height: 30,
                  child: Row(
                    children: [
                      Icon(UniconsLine.trophy),
                      SizedBox(width: 10),
                      Text("Top 100 Stocks by Market Cap",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),)]),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(5, 20, 0, 0),
              child: Stockscreen(),
            ),
          )
        ])),
    drawer: LeftDrawer(),
    );
  }
}