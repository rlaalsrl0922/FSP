import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:yahoo_finance_data_reader/yahoo_finance_data_reader.dart';




class StockChart extends StatefulWidget {

  final String ticker;
  StockChart({required this.ticker});

  @override
  State<StockChart> createState() => _StockChartState();

}

class _StockChartState extends State<StockChart> {
  late Future<List<ChartSampleData>> _chartData;
  TrackballBehavior? _trackballBehavior;

  @override
  void initState() {
    super.initState();
    _chartData = getChartData(widget.ticker);
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
            title: ChartTitle(text:widget.ticker),
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

  ChartSampleData({this.x, this.open, this.high, this.low, this.close,this.min,this.max});

  final DateTime? x;
  final num? open;
  final num? high;
  final num? low;
  final num? close;
  final num? min;
  final num? max;
}

Future<List<ChartSampleData>> getChartData(String tic) async {
  String ticker = tic;
  YahooFinanceDailyReader yahooFinanceDataReader = YahooFinanceDailyReader();

  Map<String, dynamic> historicalData = await yahooFinanceDataReader.getDailyData(ticker);

  List<ChartSampleData> chartData = [];
  historicalData.forEach((date, data) {
    print(data);

    /*
    flutter: {currency: USD, symbol: MSFT, exchangeName: NMS, fullExchangeName: NasdaqGS, instrumentType: EQUITY, firstTradeDate: 511108200,
    regularMarketTime: 1720623145, hasPrePostMarketData: true, gmtoffset: -14400, timezone: EDT, exchangeTimezoneName: America/New_York,
    regularMarketPrice: 461.285, fiftyTwoWeekHigh: 463.62, fiftyTwoWeekLow: 458.9, regularMarketDayHigh: 463.62, regularMarketDayLow: 458.9, regularMarketVolume: 3904396,
     chartPreviousClose: 0.097, priceHint: 2, currentTradingPeriod: {pre: {timezone: EDT, start: 1720598400, end: 1720618200, gmtoffset: -14400},
     regular: {timezone: EDT, start: 1720618200, end: 1720641600, gmtoffset: -14400}, post: {timezone: EDT, start: 1720641600, end: 1720656000, gmtoffset: -14400}},
     dataGranularity: 1d, range: , validRanges: [1d, 5d, 1mo, 3mo, 6mo, 1y, 2y, 5y, 10y, ytd, max]}
     */

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