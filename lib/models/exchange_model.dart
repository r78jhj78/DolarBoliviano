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
    // Validar que la estructura tenga los campos esperados
    if (json['rates'] == null || json['base_code'] == null) {
      throw Exception('JSON inválido: faltan campos requeridos.');
    }

    // Asegurar que rates sea un Map
    final rates = json['rates'];
    if (rates is! Map<String, dynamic>) {
      throw Exception('Formato inválido en rates.');
    }

    return ExchangeRate(
      base: json['base_code'],
      rates: rates,
      date: DateTime.now().toString(),
    );
  }
}
