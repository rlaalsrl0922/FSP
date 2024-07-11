import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myapp/domain/News.dart';
import 'package:myapp/domain/Fullstock.dart';


class IndividualNewsScreen extends StatelessWidget {
  final FullStockData? stock;

  IndividualNewsScreen({this.stock});

  @override
  Widget build(BuildContext context) {
    List<News> newsList = stock?.news?? [];

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