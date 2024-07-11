class News {
  final String newsTitle;
  final String newsUrl;
  final String newsPublisher;
  final String newsPublishedTime;

  News({required this.newsTitle, required this.newsUrl,required this.newsPublishedTime, required this.newsPublisher});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      newsTitle: json['title'] ?? '',
      newsUrl: json['url'] ?? '',
      newsPublisher: json['tickers'] ?? '',
      newsPublishedTime: json['time'] ?? '',
    );
  }

}