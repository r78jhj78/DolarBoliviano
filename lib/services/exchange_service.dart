import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/exchange_model.dart';

class ExchangeService {
  static const String apiUrl =
      'https://open.er-api.com/v6/latest/USD'; // Pública y gratuita

  Future<ExchangeRate> fetchExchangeRate() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ExchangeRate.fromJson(data);
    } else {
      throw Exception('Error al obtener las tasas de cambio');
    }
  }
}
