import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/widget/TopStockWidget.dart';


class ToIndividualButton extends StatelessWidget {

  final Stock? stock;
  final String ticker;
  final String url;

  ToIndividualButton({required this.stock,required this.url,required this.ticker});

  Future<void> _sendRequest(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse('$url/$ticker'),
      );
      if (response.statusCode == 200) {
        StockData stockData = StockData.fromJson(jsonDecode(response.body));
        Navigator.pushNamed(
            context, '/individual',
            arguments: stockData
        );
      } else {
        _showErrorDialog(context, 'Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
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
      child: Text(''),
    );
  }
}

class StockData {
  final String name;
  final String ticker;
  final String imageUrl;
  final String newsId;
  final String newsTitle;
  final String newsUrl;
  final String newsPublisher;
  final String newsPublishedTime;

  StockData({
    required this.name,
    required this.ticker,
    required this.imageUrl,
    required this.newsId,
    required this.newsTitle,
    required this.newsUrl,
    required this.newsPublisher,
    required this.newsPublishedTime,
  });

  factory StockData.fromJson(Map<String, dynamic> json) {
    return StockData(
      name: json['name'],
      ticker: json['tickers'],
      imageUrl: json['imageUrl'],
      newsId: json['id'],
      newsTitle: json['title'],
      newsUrl: json['url'],
      newsPublisher: json['site'],
      newsPublishedTime: json['time'],
    );
  }
}
