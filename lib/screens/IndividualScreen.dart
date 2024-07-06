import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;


class IndividualScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            Text('[Ticker]'),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
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
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
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
                    SizedBox(width: 10,),
                    Container(
                    width: 50,
                    height: 50,
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
                      Container(
                      width: 350,
                      height: 500,
                      decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
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
    );
  }
}

// StockChart 클래스 정의
class StockChart extends StatefulWidget {
  @override
  State<StockChart> createState() => _StockChartState();
}

class _StockChartState extends State<StockChart> {
  late Future<List<ChartSampleData>> _chartData;

  @override
  void initState() {
    super.initState();
    _chartData = getChartData();
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
            zoomPanBehavior: ZoomPanBehavior(
              enablePanning: true,
            ),
            primaryXAxis: DateTimeAxis(
              autoScrollingDelta: 15,
              autoScrollingMode: AutoScrollingMode.start,
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

// ChartSampleData 클래스 정의
class ChartSampleData {
  ChartSampleData({this.x, this.open, this.high, this.low, this.close});

  final DateTime? x;
  final num? open;
  final num? high;
  final num? low;
  final num? close;
}

// getChartData 함수 정의
Future<List<ChartSampleData>> getChartData() async {
  // CSV 파일 읽기
  final String rawCsv = await rootBundle.loadString('csv/msft_stock_data.csv');
  print(rawCsv);
  print('CSV Data: $rawCsv');

  List<List<dynamic>> csvTable = CsvToListConverter().convert(rawCsv);

  List<ChartSampleData> chartData = [];

  // CSV의 첫 번째 행을 스킵하고 데이터를 파싱
  for (int i = 1; i < csvTable.length; i++) {
    final row = csvTable[i];
    final DateTime date = DateTime.parse(row[0]);
    final double open = row[1];
    final double high = row[2];
    final double low = row[3];
    final double close = row[4];

    chartData.add(ChartSampleData(
      x: date,
      open: open,
      high: high,
      low: low,
      close: close,
    ));
  }

  return chartData;
}