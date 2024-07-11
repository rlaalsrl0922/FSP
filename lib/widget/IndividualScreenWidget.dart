import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myapp/widget/StockchartWidget.dart';
import 'package:myapp/domain/News.dart';
import 'package:myapp/domain/Stock.dart';



class IndividualScreenWidget extends StatelessWidget {
  final StockData? stock;

  IndividualScreenWidget({this.stock});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        IndividualAppBarWidget(stock: stock),
        Expanded(child: IndividualNewsScreen(stock: stock)),
        Expanded(child: StockChart(stock: stock))
      ],
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


