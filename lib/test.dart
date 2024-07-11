import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/widget/StockchartWidget.dart';
import 'package:myapp/domain/Fullstock.dart';
import 'package:myapp/widget/IndividualNewsWidget.dart';
import 'package:myapp/domain/TopStock.dart';

class IndividualScreen extends StatelessWidget {
  final FullStockData? stockData;
  final Stock? stock;

  IndividualScreen({this.stockData, this.stock});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
              if (stock != null)
          Container(
          width: 40,
          height: 40,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.network(
            stock!.logoUrl,
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
        ),
        if (stock != null)
    Text(
      stock!.ticker,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    Padding(
    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
      child: stock != null ? Text(stock!.name) : SizedBox.shrink(),
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
    if (stock != null)
    Text(
    stock!.price,
    style: TextStyle(
    fontSize: 20,
    color: Colors.black,
    ),
    ),
    Padding(
    padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
    child: stock != null ? Text(stock!.name) : SizedBox.shrink(),
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
    child: Container(
    width: 350,
    height: 200,
    child: stockData != null
    ? StockChart(ticker: stockData!.ticker)
        : CircularProgressIndicator(),
    ),
    ),
    ],
    ),
    ),
    ],
    ),
    ),
    ),
    Expanded(
    child: SingleChildScrollView(
    child: Column(
    mainAxisSize: MainAxisSize.max,
    children: [
    Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
    SizedBox(
    width: 20,
    ),
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
    ),
    Padding(
    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
    child: Row(
    mainAxisSize: MainAxisSize.max,
    children: [
    Text(
    'News ',
    style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    ),
    ),
    ],
    ),
    ),
    ],
    ),
    Padding(
    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
    child: Row(
    mainAxisSize: MainAxisSize.max,
    children: [
    Expanded(
    child: Container(
    width: 350,
    height: 500,
    child: stockData != null
    ? IndividualNewsScreen(stock: stockData)
        : Container(), // 예시: 혹은 다른 대체 위젯을 넣을 수 있음
    ),
    ),
    ],
    ),
    ),
    ],
    ),
    ),
    ),
    ],
    ),
    ),
    );
  }
}
