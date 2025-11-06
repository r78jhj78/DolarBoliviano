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
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final rate = snapshot.data!.rates['BOB'];
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  elevation: 4,
                  child: ListTile(
                    leading: const Icon(Icons.monetization_on, color: Colors.green),
                    title: const Text('Dólar Estadounidense → Boliviano'),
                    subtitle: Text('1 USD = $rate BOB'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(rate: rate),
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
