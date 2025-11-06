class ExchangeRate {
  final String base;
  final Map<String, dynamic> rates;
  final String date;

  ExchangeRate({
    required this.base,
    required this.rates,
    required this.date,
  });

  factory ExchangeRate.fromJson(Map<String, dynamic> json) {
    return ExchangeRate(
      base: json['base_code'],
      rates: json['conversion_rates'],
      date: DateTime.now().toString(),
    );
  }
}
