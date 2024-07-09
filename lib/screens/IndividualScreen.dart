import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/screens/LeftDrawer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:myapp/screens/IndividualNewsScreen.dart';


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

// StockChart 클래스 정의
class StockChart extends StatefulWidget {
  @override
  State<StockChart> createState() => _StockChartState();
}

class _StockChartState extends State<StockChart> {
  late Future<List<ChartSampleData>> _chartData;
  TrackballBehavior? _trackballBehavior;

  @override
  void initState() {
    super.initState();
    _chartData = getChartData();
    _trackballBehavior = TrackballBehavior(
      enable: true, activationMode: ActivationMode.longPress);
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
            title: ChartTitle(text: 'MSFT'),
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
  final String rawCsv = await rootBundle.loadString('assets/csv/msft.csv');

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