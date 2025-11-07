import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/crypto_model.dart';

class CryptoDetailScreen extends StatelessWidget {
  final Crypto crypto;

  const CryptoDetailScreen({super.key, required this.crypto});

  @override
  Widget build(BuildContext context) {
    final isPositive = crypto.priceChangePercentage24h >= 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('${crypto.name} (${crypto.symbol})'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Hero(
              tag: crypto.id,
              child: CircleAvatar(
                backgroundImage: NetworkImage(crypto.image),
                radius: 60,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              crypto.name,
              style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              crypto.symbol,
              style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.tealAccent.withOpacity(0.2),
                    Colors.blueGrey.withOpacity(0.1)
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _infoRow(
                    'Precio actual',
                    '\$${crypto.currentPrice.toStringAsFixed(2)}',
                    FontAwesomeIcons.dollarSign,
                    Colors.tealAccent,
                  ),
                  const Divider(color: Colors.grey),
                  _infoRow(
                    'Cambio 24h',
                    '${crypto.priceChangePercentage24h.toStringAsFixed(2)}%',
                    isPositive
                        ? FontAwesomeIcons.arrowTrendUp
                        : FontAwesomeIcons.arrowTrendDown,
                    isPositive ? Colors.greenAccent : Colors.redAccent,
                  ),
                  const Divider(color: Colors.grey),
                  _infoRow(
                    'Capitalización',
                    '\$${crypto.marketCap.toStringAsFixed(0)}',
                    FontAwesomeIcons.chartColumn,
                    Colors.amberAccent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(
      String title, String value, IconData icon, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    fontSize: 16, color: Colors.white70, letterSpacing: 0.5)),
          ),
          Text(
            value,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: iconColor, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
