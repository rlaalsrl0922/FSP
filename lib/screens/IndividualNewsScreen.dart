import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class IndividualNewsScreen extends StatelessWidget {
  // Example data
  final List<News> newses = [
        News(title: 'Apple launches new iPhone', url: 'https://news.example.com/apple1'),
        News(title: 'Apple Q2 earnings report', url: 'https://news.example.com/apple2'),
    News(title: 'Apple Q2 earnings report', url: 'https://news.example.com/apple2'),
    News(title: 'Apple Q2 earnings report', url: 'https://news.example.com/apple2'),
    News(title: 'Apple Q2 earnings report', url: 'https://news.example.com/apple2'),
    News(title: 'Apple Q2 earnings report', url: 'https://news.example.com/apple2'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newses.length,
      itemBuilder: (context, index) {
        final news = newses[index];
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
                ElevatedButton(onPressed: () {
                  _launchURL(news.url);
                },
                    child: Text(news.title, style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold))
                )
              ],
            )
        )
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

class News {
  final String title;
  final String url;
  //final String date;

  //News({required this.title, required this.url,required this.date});
  News({required this.title, required this.url});
}