import 'package:flutter/material.dart';

import '../models/expense.dart';
import 'add_expense_screen.dart';
import 'budget_screen.dart';
import 'investment_screen.dart';

class DashboardScreen extends StatelessWidget {
  final List<Expense> expenses;
  final VoidCallback onToggleTheme;
  final ValueChanged<Expense> onAddExpense;

  const DashboardScreen({
    super.key,
    required this.expenses,
    required this.onToggleTheme,
    required this.onAddExpense,
  });

  double get totalSpent {
    return expenses.fold(
      0,
      (sum, expense) => sum + expense.amount,
    );
  }

  @override
  Widget build(BuildContext context) {
    final balance = 50000 - totalSpent;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Finance Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: onToggleTheme,
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Balance Card
          Card(
            color: Theme.of(context).colorScheme.primary,
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Balance',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '₹ ${balance.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Total Spent
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.money_off),
              ),
              title: const Text('Total Spent'),
              subtitle: const Text(
                'Current expense total',
              ),
              trailing: Text(
                '₹ ${totalSpent.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Add Expense
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                final result =
                    await Navigator.push<Expense>(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const AddExpenseScreen(),
                  ),
                );

                if (result != null) {
                  onAddExpense(result);
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('+ Add Expense'),
            ),
          ),

          const SizedBox(height: 12),

          // Budget
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BudgetScreen(
                      expenses: expenses,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.account_balance_wallet,
              ),
              label: const Text(
                'View Budget & Expenses',
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Investments
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const InvestmentScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.trending_up),
              label: const Text(
                'View Investments',
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Recent Expenses
          if (expenses.isNotEmpty) ...[
            const Text(
              'Recent Expenses',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            ...expenses.reversed.take(5).map(
              (expense) {
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.receipt),
                    ),
                    title: Text(expense.title),
                    subtitle: Text(expense.category),
                    trailing: Text(
                      '₹ ${expense.amount.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}