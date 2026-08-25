import 'package:flutter/material.dart';

import '../data/investment_data.dart';

class InvestmentScreen extends StatelessWidget {
  const InvestmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investments'),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(12),

        itemCount: investments.length,

        itemBuilder: (context, index) {
          final investment =
              investments[index];

          final positive =
              investment.changePercent >= 0;

          return Card(
            margin: const EdgeInsets.only(
              bottom: 12,
            ),

            child: ListTile(
              contentPadding:
                  const EdgeInsets.all(16),

              leading: CircleAvatar(
                child: Icon(
                  positive
                      ? Icons.trending_up
                      : Icons.trending_down,
                ),
              ),

              title: Text(
                investment.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),

              subtitle: Padding(
                padding: const EdgeInsets.only(
                  top: 6,
                ),
                child: Text(
                  '₹${investment.value.toStringAsFixed(0)}',
                ),
              ),

              trailing: Text(
                '${positive ? '+' : ''}'
                '${investment.changePercent}%',
                style: TextStyle(
                  color: positive
                      ? Colors.green
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}