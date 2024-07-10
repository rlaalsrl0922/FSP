import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Stockscreen extends StatelessWidget {
  // Example data
  final List<Stock> stocks = [
    Stock(
      logoUrl: 'https://example.com/logo1.png',
      ticker: 'AAPL',
      name: 'Apple Inc.',
    ),
    Stock(
      logoUrl: 'https://example.com/logo1.png',
      ticker: 'AAPL',
      name: 'Apple Inc.',
    ),Stock(
      logoUrl: 'https://example.com/logo1.png',
      ticker: 'AAPL',
      name: 'Apple Inc.',
    ),Stock(
      logoUrl: 'https://example.com/logo1.png',
      ticker: 'AAPL',
      name: 'Apple Inc.',
    ),Stock(
      logoUrl: 'https://example.com/logo1.png',
      ticker: 'AAPL',
      name: 'Apple Inc.',
    ),Stock(
      logoUrl: 'https://example.com/logo1.png',
      ticker: 'AAPL',
      name: 'Apple Inc.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        final stock = stocks[index];
        return StockCard(stock: stock);
      },
    );
  }
}

class StockCard extends StatelessWidget {
  final Stock stock;

  StockCard({required this.stock});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(onPressed: () => {Navigator.pushNamed(context,'/home')},
                child: Container(
                  child: Row(children: [Container(
                    width: 60,
                    height: 60,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      stock.logoUrl,
                      height: 50,
                      width: 50,
                    ),
                  ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                    Text(stock.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                    ),
                    Text(stock.ticker, style: TextStyle(color: Colors.grey)),
                  ],),
                )
            ),
          ],
        ),
      ),
    );
  }
}

class MyRequestButton extends StatelessWidget {
  final String ticker;
  String url = 'http://localhost:8080/stock';

  MyRequestButton({required this.ticker,required this.url});

  Future<void> _sendRequest(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse('$url?ticker=$ticker'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _showResponseDialog(context, data);
      } else {
        _showErrorDialog(context, 'Error: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorDialog(context, 'Error: $e');
    }
  }

  void _showResponseDialog(BuildContext context, Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Response Data'),
        content: Text(data.toString()),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _sendRequest(context),
      child: Text('Send Request'),
    );
  }
}

class StockTile extends StatelessWidget {
  final Stock stock;

  StockTile({required this.stock});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(stock.name),
      leading: Icon(UniconsLine.newspaper),
      onTap: () async {
        if (await canLaunch(stock.logoUrl)) {
          await launch(stock.logoUrl);
        } else {
          throw 'Could not launch ${stock.logoUrl}';
        }
      },
    );
  }
}

class Stock {
  final String logoUrl;
  final String ticker;
  final String name;

  Stock({
    required this.logoUrl,
    required this.ticker,
    required this.name,
  });
}


