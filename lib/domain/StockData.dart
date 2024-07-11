import 'package:myapp/domain/News.dart';

class StockData {
  final String name;
  final String ticker;
  final String imageUrl;
  final List<News> news;

  StockData({
    required this.name,
    required this.ticker,
    required this.imageUrl,
    required this.news,
  });

  factory StockData.fromJson(Map<String, dynamic> json) {
    var newsList = (json['news'] as List)
        .map((newsJson) => News.fromJson(newsJson))
        .toList();

    return StockData(
      name: json['name'],
      ticker: json['tickers'],
      imageUrl: json['imageUrl'],
      news: newsList,
    );
  }

  List<News> toNewsList() {
    return news;
  }
}
/*
class News {
  final String newsTitle;
  final String newsUrl;
  final String newsPublisher;
  final String newsPublishedTime;
 */