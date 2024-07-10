import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class CompanyNewsScreen extends StatelessWidget {
  // Example data
  final List<Company> companies = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: companies.length,
      itemBuilder: (context, index) {
        final company = companies[index];
        return CompanyCard(company: company);
      },
    );
  }
}

class CompanyCard extends StatelessWidget {
  final Company company;

  CompanyCard({required this.company});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row( children: [Container(
                width: 60,
                height: 60,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape:BoxShape.circle,
                ),
                child: Image.network(
                  company.logoUrl,
                  height: 50,
                  width: 50,
                )),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    company.ticker,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    company.name,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: company.news.map((news) => NewsTile(news: news)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsTile extends StatelessWidget {
  final News news;

  NewsTile({required this.news});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(news.newsTitle),
      leading: Icon(UniconsLine.newspaper),
      onTap: () async {
        if (await canLaunch(news.newsUrl)) {
          await launch(news.newsUrl);
        } else {
          throw 'Could not launch ${news.newsUrl}';
        }
      },
    );
  }
}

class Company {
  final String logoUrl;
  final String ticker;
  final String name;
  final List<News> news;

  Company({
    required this.logoUrl,
    required this.ticker,
    required this.name,
    required this.news,
  });
}

class News {
  final String newsTitle;
  final String newsUrl;
  final String newsPublisher;
  final String newsPublishedTime;

  News({required this.newsTitle, required this.newsUrl,required this.newsPublishedTime, required this.newsPublisher});
}