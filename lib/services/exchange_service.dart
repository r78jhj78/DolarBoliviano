import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/exchange_model.dart';

class ExchangeService {
  static const String apiUrl = 'https://open.er-api.com/v6/latest/USD';

  Future<ExchangeRate> fetchExchangeRate() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      print('>>> Respuesta del servidor:\n${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Error HTTP ${response.statusCode}');
      }

      final data = json.decode(response.body);

      if (data == null || data is! Map<String, dynamic>) {
        throw Exception('Respuesta no válida (no es JSON).');
      }

      if (data['result'] != 'success') {
        throw Exception('API devolvió error: ${data['error-type'] ?? 'desconocido'}');
      }

     if (data['rates'] == null) {
      throw Exception('No se encontraron tasas de cambio.');
    }

      return ExchangeRate.fromJson(data);
    } catch (e) {
      throw Exception('Error al obtener las tasas de cambio: $e');
    }
  }
}
