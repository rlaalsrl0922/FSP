  import 'dart:convert';
  import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;
  import 'package:myapp/domain/TopStock.dart';
  import 'package:myapp/domain/Fullstock.dart';
  import 'package:myapp/domain/StockData.dart';
/*

  class ToIndividualButton extends StatelessWidget {

    final Stock stock;
    final String ticker;
    final String url;

    ToIndividualButton({
      required this.stock,
      required this.url,
      required this.ticker});

    Future<void> _sendRequest(BuildContext context) async {
      print('Button pressed: Sending request to $url/$ticker');
      try {
        final response = await http.get(
          Uri.parse('$url/$ticker'),
        );
        if (response.statusCode == 200) {
          StockData stockData = StockData.fromJson(jsonDecode(response.body));

          // 정보들 통합해서 보내주기
          FullStockData fullStockData = FullStockData.fromStockAndStockData(stock, stockData);
          print(fullStockData);

          Navigator.pushNamed(
              context, '/individual',
              arguments: fullStockData
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
        child: Text('To Individual'),
      );
    }
  }*/
