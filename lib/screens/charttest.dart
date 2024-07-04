import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: SizedBox(
            width: 400,
            height: 400,
            child: MyHomePage(title: 'Flutter Demo Home Page'),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 400,
        height: 400,
        child: StockChartScreen(),
      ),
    );
  }
}

class StockChartScreen extends StatefulWidget {
  const StockChartScreen({Key? key}) : super(key: key);

  @override
  _StockChartScreenState createState() => _StockChartScreenState();
}

class _StockChartScreenState extends State<StockChartScreen> {
  List<FlSpot> prices = [];
  double minY = double.infinity;
  double maxY = double.negativeInfinity;
  DateTime? minX;
  DateTime? maxX;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCSVData();
  }

  Future<void> loadCSVData() async {
    try {
      final rawData = await rootBundle.loadString("asset/csv/msft_stock_data.csv");
      List<List<dynamic>> csvTable = CsvToListConverter().convert(rawData);

      for (int i = 1; i < csvTable.length; i++) {
        DateTime date = DateTime.parse(csvTable[i][0]);
        double closePrice = csvTable[i][4].toDouble();

        if (closePrice < minY) minY = closePrice;
        if (closePrice > maxY) maxY = closePrice;
        if (minX == null || date.isBefore(minX!)) minX = date;
        if (maxX == null || date.isAfter(maxX!)) maxX = date;

        prices.add(FlSpot(date.millisecondsSinceEpoch.toDouble(), closePrice));
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error loading CSV data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MSFT Stock Chart')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 800,  // 임의로 설정한 너비입니다. 데이터에 맞게 조정할 수 있습니다.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 22,
                          getTitlesWidget: (value, meta) {
                            DateTime date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                            return Text(
                              DateFormat('MMM yyyy').format(date),
                              style: TextStyle(
                                color: Color(0xff68737d),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              '\$${value.toStringAsFixed(0)}',
                              style: TextStyle(
                                color: Color(0xff67727d),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            );
                          },
                          reservedSize: 40,
                        ),
                      ),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: true),
                    minX: minX?.millisecondsSinceEpoch.toDouble(),
                    maxX: maxX?.millisecondsSinceEpoch.toDouble(),
                    minY: minY,
                    maxY: maxY,
                    lineBarsData: [
                      LineChartBarData(
                        spots: prices,
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 2,
                        isStrokeCapRound: true,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
