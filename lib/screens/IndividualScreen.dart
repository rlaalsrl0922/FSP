import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class IndividualScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
        child: Container(
          width: 120,
          height: 120,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.network(
            'assets/images/download.png',
          ),
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            '[Ticker]'
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
            child: Text(
              '[Stock Name]',
            ),
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
        padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
        child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
        Text(
        'Stock Price ',
          style: TextStyle(
              fontSize: 20,
              color: Colors.black)
    ),
    Padding(
    padding:
    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
    child: Text(
    'Stock change(+) (Stock change(%))',),),],
    ),
    ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 350,
                  height: 200,
                  child: StockChart()
                  ),
              ],
            ),
          ),
        ])))
        ])));
  }
}

class StockChart extends StatefulWidget{
  @override
  State<StockChart> createState() => _StockChartState();
}
class _StockChartState extends State<StockChart> {

  late List<ChartSampleData> _chartData;
  @override
  void initState() {
    _chartData = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SfCartesianChart(
            series: <CandleSeries>[
              CandleSeries<ChartSampleData,DateTime>(dataSource: _chartData,
              xValueMapper: (ChartSampleData sales, _) => sales.x,
              lowValueMapper: (ChartSampleData sales, _)=> sales.low,
              highValueMapper: (ChartSampleData sales, _)=> sales.high,
              openValueMapper: (ChartSampleData sales, _)=> sales.open,
              closeValueMapper: (ChartSampleData sales, _)=> sales.close)
            ],
            primaryXAxis: DateTimeAxis(),

    ),));
  }
  List<ChartSampleData> getChartData(){
    return <ChartSampleData>[];
  }
}

class ChartSampleData {
  ChartSampleData({
    this.x,
    this.open,
    this.close,
    this.low,
    this.high
  });
  final DateTime? x;
  final num? open;
  final num? close;
  final num? low;
  final num? high;

}

