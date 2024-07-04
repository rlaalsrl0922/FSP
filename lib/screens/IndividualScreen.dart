import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class IndividualScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar : AppBar(
      backgroundColor: FlutterFlowTheme.of(context).primary,
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
            // 티커 이미지 경로
            'https://picsum.photos/seed/625/600',
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                '[Ticker]',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
            child: Text(
              '[Stock Name]',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Outfit',
                color: Colors.white,
                fontSize: 22,
                letterSpacing: 0,
              ),
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
        style: FlutterFlowTheme.of(context)
            .bodyMedium
            .override(
        fontFamily: 'Readex Pro',
    fontSize: 20,
    letterSpacing: 0,
    ),
    ),
    Padding(
    padding:
    EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
    child: Text(
    'Stock change(+) (Stock change(%))',
    style: FlutterFlowTheme.of(context)
        .bodyMedium
        .override(
    fontFamily: 'Readex Pro',
    letterSpacing: 0,
    ),),),],
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

