import 'package:myapp/domain/TopStock.dart';
import 'package:myapp/domain/StockData.dart';
import 'package:myapp/domain/News.dart';

class FullStockData {
  final String logoUrl;
  final String ticker;
  final String name;
  final String price;
  final String today;
  final List<News> news;

  FullStockData({
    required this.logoUrl,
    required this.ticker,
    required this.name,
    required this.price,
    required this.today,
    required this.news
  });

  factory FullStockData.fromStockAndStockData(Stock stock, List<News> newsList) {
    return FullStockData(
      logoUrl: stock.logoUrl,
      ticker: stock.ticker,
      name: stock.name,
      price: stock.price,
      today: stock.today,
      news : newsList
    );
  }
}