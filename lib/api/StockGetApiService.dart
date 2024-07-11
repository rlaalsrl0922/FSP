import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myapp/domain/TopStock.dart';

class StockGetApiService {

  final String apiUrl = 'http://localhost:8080/stocks/top100';

  Future<List<Stock>> getStockData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> top100List = jsonResponse['top100'];
        List<Stock> stocks = top100List.map((json) => Stock.fromJson(json)).toList();
        return stocks;
      } else {
        print('Get Error: ${response.statusCode}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Get Error: $e');
      throw Exception('Failed to connect to server');
    }
  }
}
