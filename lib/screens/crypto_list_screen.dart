import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/crypto_model.dart';
import '../services/crypto_service.dart';
import 'crypto_detail_screen.dart';

class CryptoListScreen extends StatelessWidget {
  final CryptoService _cryptoService = CryptoService();

  CryptoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CryptoTracker Pro 💹'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Crypto>>(
        future: _cryptoService.fetchCryptos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.tealAccent));
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          } else if (snapshot.hasData) {
            final cryptos = snapshot.data!;
            return ListView.builder(
              itemCount: cryptos.length,
              itemBuilder: (context, index) {
                final crypto = cryptos[index];
                final isPositive = crypto.priceChangePercentage24h >= 0;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CryptoDetailScreen(crypto: crypto),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.teal.withOpacity(0.15),
                            Colors.blueGrey.withOpacity(0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(crypto.image),
                          radius: 25,
                        ),
                        title: Text(
                          crypto.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        subtitle: Text(
                          crypto.symbol,
                          style: TextStyle(
                              color: Colors.grey.shade400, fontSize: 13),
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '\$${crypto.currentPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isPositive
                                      ? FontAwesomeIcons.arrowTrendUp
                                      : FontAwesomeIcons.arrowTrendDown,
                                  color: isPositive
                                      ? Colors.greenAccent
                                      : Colors.redAccent,
                                  size: 12,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${crypto.priceChangePercentage24h.toStringAsFixed(2)}%',
                                  style: TextStyle(
                                    color: isPositive
                                        ? Colors.greenAccent
                                        : Colors.redAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No hay datos disponibles.'));
          }
        },
      ),
    );
  }
}
