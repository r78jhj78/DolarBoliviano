import 'package:flutter/material.dart';
import '../models/exchange_model.dart';
import '../services/exchange_service.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ExchangeService _service = ExchangeService();
  late Future<ExchangeRate> _futureRate;

  // Valor fijo del dólar paralelo (puedes actualizarlo luego)
  static const double dolarParalelo = 11.00;

  @override
  void initState() {
    super.initState();
    _futureRate = _service.fetchExchangeRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasa de Cambio USD ↔ BOB')),
      body: FutureBuilder<ExchangeRate>(
        future: _futureRate,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final rateOficial = snapshot.data!.rates['BOB'];

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  '💵 Tasas de cambio actuales:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                // Dólar oficial
                Card(
                  elevation: 4,
                  child: ListTile(
                    leading: const Icon(Icons.account_balance, color: Colors.green),
                    title: const Text('Dólar Oficial (Banco Central)'),
                    subtitle: Text('1 USD = ${rateOficial.toStringAsFixed(3)} BOB'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(rate: rateOficial),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 10),

                // Dólar paralelo
                Card(
                  color: Colors.orange.shade50,
                  elevation: 4,
                  child: ListTile(
                    leading: const Icon(Icons.trending_up, color: Colors.orange),
                    title: const Text('Dólar Paralelo / Mercado Negro'),
                    subtitle: Text('1 USD = ${dolarParalelo.toStringAsFixed(2)} BOB'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(rate: dolarParalelo),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No hay datos disponibles.'));
          }
        },
      ),
    );
  }
}
