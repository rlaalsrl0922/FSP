import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:yahoo_finance_data_reader/yahoo_finance_data_reader.dart';




class StockChart extends StatefulWidget {
  @override
  State<StockChart> createState() => _StockChartState();
}

class _StockChartState extends State<StockChart> {
  late Future<List<ChartSampleData>> _chartData;
  TrackballBehavior? _trackballBehavior;
  String ticker='MSFT';
  @override
  void initState() {
    super.initState();
    _chartData = getChartData(ticker);
    _trackballBehavior = TrackballBehavior(
        enable: true,
        activationMode: ActivationMode.longPress
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ChartSampleData>>(
      future: _chartData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final data = snapshot.data ?? [];
          return SfCartesianChart(
            title: ChartTitle(text: ticker),
            trackballBehavior: _trackballBehavior,
            zoomPanBehavior: ZoomPanBehavior(
              enablePanning: true,
            ),
            primaryXAxis: DateTimeAxis(
              autoScrollingDelta: 15,
              autoScrollingMode: AutoScrollingMode.start,
              majorGridLines: MajorGridLines(width:0),
            ),
            series: <CandleSeries>[
              CandleSeries<ChartSampleData, DateTime>(
                dataSource: data,
                xValueMapper: (ChartSampleData sales, _) => sales.x!,
                lowValueMapper: (ChartSampleData sales, _) => sales.low!,
                highValueMapper: (ChartSampleData sales, _) => sales.high!,
                openValueMapper: (ChartSampleData sales, _) => sales.open!,
                closeValueMapper: (ChartSampleData sales, _) => sales.close!,
              ),
            ],
          );
        }
      },
    );
  }
}


class ChartSampleData {

  ChartSampleData({this.x, this.open, this.high, this.low, this.close});

  final DateTime? x;
  final num? open;
  final num? high;
  final num? low;
  final num? close;
}

Future<List<ChartSampleData>> getChartData(String tic) async {
  String ticker = tic;
  YahooFinanceDailyReader yahooFinanceDataReader = YahooFinanceDailyReader();

  Map<String, dynamic> historicalData = await yahooFinanceDataReader.getDailyData(ticker);

  List<ChartSampleData> chartData = [];
  historicalData.forEach((date, data) {
    print(date);
    print(data);
    DateTime parsedDate = DateTime.parse(date);
    chartData.add(ChartSampleData(
      x: parsedDate,
      open: data['open'],
      high: data['high'],
      low: data['low'],
      close: data['close'],
    ));
  });

  return chartData;
}