import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myapp/api/StockGetApiService.dart';


class Stockscreen extends StatelessWidget {

  final StockGetApiService stockGetApiService = StockGetApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Stock>>(
        future: stockGetApiService.getStockData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final stock = snapshot.data![index];
                return StockCard(stock: stock);
              },
            );
          }
        },
      ),
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
            ElevatedButton(
                onPressed: () => {
                      Navigator.pushNamed(context, '/individual',
                          arguments: stock)
                    },
                child: Row(children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            stock.logoUrl,
                            height: 40,
                            width: 40,
                          ),
                        ),
                        Text(stock.ticker,
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(stock.ticker, style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(width: 20),
                  Text(stock.price, style: TextStyle(
                      fontSize: 12)),
                  SizedBox(width: 10),
                  Text(stock.today, style: TextStyle(
                      fontSize: 9)),
                ])),
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
  final String price;
  final String today;

  Stock({
    required this.logoUrl,
    required this.ticker,
    required this.name,
    required this.price,
    required this.today
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      name: json['name'],
      ticker: json['ticker'],
      logoUrl: json['logoUrl'],
      price: json['price'],
      today: json['today'],
    );
  }

}