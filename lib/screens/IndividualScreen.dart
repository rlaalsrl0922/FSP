import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:unicons/unicons.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/screens/Indicator.dart';

class IndividualScreen extends StatelessWidget {
  final Map info = {
    //
    'titleImageLink': 'https://storage.googleapis.com/cms-storage-bucket/'
        '2f118a9971e4ca6ad737.png',
    'titleSectionHeader': 'Flutter on Mobile',
    'titleSectionBody': 'https://flutter.dev/multi-platform/mobile',
    'titleSectionScore': 100,
    'textSection': '(Ticker) StockName',
  };
  @override
  Widget build(BuildContext context) {
    //final titleImage = _buildTitle(info['ImageLink']);

    Widget titleSection = _buildTitleSection(
        info['titleImageLink'], info['textSection'], info['titleSectionScore']);
    //Widget graphSection = _buildGraphSection();
    Widget indicatorSection = _buildIndicatorSection();
    Widget searchBarSection = SearchBar(leading: Icon(Icons.search));

    return Scaffold(
      body: ListView(
        children: [
          searchBarSection,
          titleSection,
          //indicatorSection,
        ],
      ),
    );
    /*
    return Scaffold(
        body: Column(
      children: [
        titleSection,
        indicatorSection,
      ],
    ));*/
  }
}

Widget _buildIndicatorSection() {
  return Indicators();
}

Container _buildTitleSection(String imageName, String stockName, int count) {
  return Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              padding: const EdgeInsets.only(right: 16),
              child: const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('imgs/warren_buffett.jpg'),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 90),
              child: Text(
                stockName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Counter(),
          ]),
        ),
      ],
    ),
  );
}

class Counter extends StatefulWidget {
  const Counter({
    Key? key,
  }) : super(key: key);

  @override
  State<Counter> createState() => CounterState();
}

class CounterState extends State<Counter> {
  int _counter = 0;
  bool _boolStatus = false;
  Color _statusColor = Colors.black;

  void _buttnPressed() {
    setState(() {
      if (_boolStatus == true) {
        _boolStatus = false;
        _counter--;
        _statusColor = Colors.black;
      } else {
        _boolStatus = true;
        _counter++;
        _statusColor = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.star),
          color: _statusColor,
          onPressed: _buttnPressed,
        ),
        Text('$_counter'),
      ],
    );
  }
}