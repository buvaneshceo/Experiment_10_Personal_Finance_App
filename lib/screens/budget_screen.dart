import 'package:flutter/material.dart';

import '../models/expense.dart';

class BudgetScreen extends StatelessWidget {
  final List<Expense> expenses;

  const BudgetScreen({
    super.key,
    required this.expenses,
  });

  static const Map<String, double> budgets = {
    'Food': 6000.0,
    'Travel': 2000.0,
    'Bills': 5000.0,
    'Shopping': 4000.0,
  };

  double calculateSpent(String category) {
    return expenses
        .where(
          (expense) => expense.category == category,
        )
        .fold(
          0.0,
          (sum, expense) => sum + expense.amount,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Budget & Expenses',
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: budgets.keys.map(
          (category) {
            final spent =
                calculateSpent(category);

            final limit = budgets[category]!;

            final ratio =
                (spent / limit).clamp(0.0, 1.0);

            final exceeded = spent > limit;

            return Card(
              margin: const EdgeInsets.only(
                bottom: 16,
              ),

              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,

                      children: [
                        Text(
                          category,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        Text(
                          '₹${spent.toStringAsFixed(0)} / '
                          '₹${limit.toStringAsFixed(0)}',
                          style: TextStyle(
                            color: exceeded
                                ? Colors.red
                                : null,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    LinearProgressIndicator(
                      value: ratio,
                      minHeight: 10,
                      color: exceeded
                          ? Colors.red
                          : Colors.green,
                      backgroundColor:
                          Colors.grey.shade300,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      exceeded
                          ? 'Budget exceeded'
                          : 'Remaining: ₹${(limit - spent).toStringAsFixed(0)}',
                      style: TextStyle(
                        color: exceeded
                            ? Colors.red
                            : Colors.green,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}