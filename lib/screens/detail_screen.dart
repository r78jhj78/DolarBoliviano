import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final double rate;

  const DetailScreen({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    double bolivianos = 0;
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Conversor USD → BOB')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Convierte dólares a bolivianos en tiempo real',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cantidad en USD',
              ),
              onChanged: (value) {
                bolivianos = (double.tryParse(value) ?? 0) * rate;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final usd = double.tryParse(controller.text) ?? 0;
                final result = usd * rate;
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Resultado'),
                    content: Text('$usd USD = ${result.toStringAsFixed(2)} BOB'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Convertir'),
            ),
            const Spacer(),
            Text(
              'Tasa actual: $rate BOB',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
