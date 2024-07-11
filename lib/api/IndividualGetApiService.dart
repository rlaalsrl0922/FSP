import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/domain/TopStock.dart';
import 'package:myapp/domain/Fullstock.dart';
import 'package:myapp/api/TokenStorage.dart';
import 'package:myapp/domain/News.dart';


class IndividualGetApiService {
  final Stock? stock;
  final String apiUrl;

  IndividualGetApiService({this.apiUrl = 'http://localhost:8080/news', required this.stock});

  Future<FullStockData> getIndividualStockData() async {
    final accessToken = await TokenStorage.getAccessToken();
    try {
      print('try access to $apiUrl/${stock!.ticker}');
      final response = await http.get(
        Uri.parse('$apiUrl/${stock!.ticker.toLowerCase()}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
      );
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> parsedJson = jsonDecode(response.body).cast<Map<String, dynamic>>();
        List<News> newsList = parsedJson.map((json) => News.fromJson(json)).toList();
        FullStockData fullStockData = FullStockData.fromStockAndStockData(stock!, newsList);
        return fullStockData;
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}
