import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/tab/LeftDrawer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:myapp/screens/IndividualNewsScreen.dart';
import 'package:myapp/widget/StockchartWidget.dart';


class IndividualScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 40,
              height: 40,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                'assets/images/download.png',
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
            ),
            Text('[Ticker]',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
              child: Text('[Stock Name]'),
            ),
          ],
        ),
      ),
      body: SafeArea(
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
                      padding: EdgeInsetsDirectional.fromSTEB(10, 20, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              child:Container(
                                  width: 350,
                                  height: 200,
                                  child: StockChart()
                              )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 20,),
                      Container(
                        width: 30,
                        height: 30,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://cdn-icons-png.flaticon.com/512/4363/4363382.png',
                        ),
                      ),Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                        child: Row( mainAxisSize: MainAxisSize.max,
                          children: [Text('News ',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          ],
                        ),
                      ),
                    ],),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(child:
                        Container(
                          width: 350,
                          height: 500,
                          child: IndividualNewsScreen(),
                        )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
      drawer: LeftDrawer(),
    );
  }
}

