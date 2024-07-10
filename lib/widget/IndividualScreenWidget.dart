import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myapp/model/ToptoIndividualModel.dart';

// Stock 클래스와 StockNews 클래스 정의가 필요할 수 있습니다. 이 부분은 생략했습니다.

class IndividualScreenWidget extends StatelessWidget {
  final StockData? stock;

  IndividualScreenWidget({this.stock});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IndividualAppBarWidget(stock: stock),
      body: IndividualNewsScreen(stock : stock),
    );
  }
}

class IndividualAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final StockData? stock;

  IndividualAppBarWidget({this.stock});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 40,
            height: 40,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.network(
              stock!.imageUrl,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
          ),
          Text(
            stock!.ticker,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
            child: Text(stock!.name),
          ),
        ],
      ),
    );
  }
}

class IndividualNewsScreen extends StatelessWidget {
  final StockData? stock;

  IndividualNewsScreen({this.stock});

  @override
  Widget build(BuildContext context) {
    List<News> newsList = stock?.news ?? [];

    return ListView.builder(
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        final news = newsList[index];
        return NewsCard(news: news);
      },
    );
  }
}

class NewsCard extends StatelessWidget {
  final News news;

  NewsCard({required this.news});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                _launchURL(news.newsUrl);
              },
              child: Text(
                news.newsTitle,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(news.newsPublisher),
            SizedBox(height: 5),
            Text(news.newsPublishedTime),
          ],
        ),
      ),
    );
  }
}

void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}


class StockData {
  final String name;
  final String ticker;
  final String imageUrl;
  final List<News> news; // List to hold news data

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


class News {
  final String newsTitle;
  final String newsUrl;
  final String newsPublisher;
  final String newsPublishedTime;

  News({required this.newsTitle, required this.newsUrl,required this.newsPublishedTime, required this.newsPublisher});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      newsTitle: json['newsTitle'],
      newsUrl: json['newsUrl'],
      newsPublisher: json['newsPublisher'],
      newsPublishedTime: json['newsPublishedTime'],
    );
  }

}
