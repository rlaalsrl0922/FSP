import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyNewsScreen extends StatelessWidget {
  // Example data
  final List<Company> companies = [
    Company(
      logoUrl: 'https://example.com/logo1.png',
      ticker: 'AAPL',
      name: 'Apple Inc.',
      news: [
        News(title: 'Apple launches new iPhone', url: 'https://news.example.com/apple1'),
        News(title: 'Apple Q2 earnings report', url: 'https://news.example.com/apple2'),
      ],
    ),
    Company(
      logoUrl: 'https://example.com/logo2.png',
      ticker: 'GOOGL',
      name: 'Alphabet Inc.',
      news: [
        News(title: 'Google announces new AI features', url: 'https://news.example.com/google1'),
        News(title: 'Alphabet Q2 earnings report', url: 'https://news.example.com/google2'),
      ],
    ),
    Company(
      logoUrl: 'https://example.com/logo2.png',
      ticker: 'GOOGL',
      name: 'Alphabet Inc.',
      news: [
        News(title: 'Google announces new AI features', url: 'https://news.example.com/google1'),
        News(title: 'Alphabet Q2 earnings report', url: 'https://news.example.com/google2'),
      ],
    ),
    Company(
      logoUrl: 'https://example.com/logo2.png',
      ticker: 'GOOGL',
      name: 'Alphabet Inc.',
      news: [
        News(title: 'Google announces new AI features', url: 'https://news.example.com/google1'),
        News(title: 'Alphabet Q2 earnings report', url: 'https://news.example.com/google2'),
      ],
    ),
    Company(
      logoUrl: 'https://example.com/logo2.png',
      ticker: 'GOOGL',
      name: 'Alphabet Inc.',
      news: [
        News(title: 'Google announces new AI features', url: 'https://news.example.com/google1'),
        News(title: 'Alphabet Q2 earnings report', url: 'https://news.example.com/google2'),
      ],
    ),
    // Add more companies here
  ];

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
            Row(
              children: [
                Image.network(
                  company.logoUrl,
                  height: 50,
                  width: 50,
                ),
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
      title: Text(news.title),
      onTap: () async {
        if (await canLaunch(news.url)) {
          await launch(news.url);
        } else {
          throw 'Could not launch ${news.url}';
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
  final String title;
  final String url;

  News({required this.title, required this.url});
}