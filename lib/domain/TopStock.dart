class Stock {
  final String logoUrl;
  final String ticker;
  final String name;
  final String price;
  final String today;

  Stock({
    required this.logoUrl,
    required this.ticker,
    required this.name,
    required this.price,
    required this.today
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      name: json['name'],
      ticker: json['ticker'],
      logoUrl: json['logoUrl'],
      price: json['price'],
      today: json['today'],
    );
  }

}