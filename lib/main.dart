import 'package:flutter/material.dart';

import 'models/expense.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const FinanceApp());
}

class FinanceApp extends StatefulWidget {
  const FinanceApp({super.key});

  @override
  State<FinanceApp> createState() => _FinanceAppState();
}

class _FinanceAppState extends State<FinanceApp> {
  ThemeMode mode = ThemeMode.light;

  final List<Expense> expenses = [];

  void toggleTheme() {
    setState(() {
      mode = mode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  void addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    final lightScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF12305A),
    );

    final darkScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF12305A),
      brightness: Brightness.dark,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FinTrack',

      themeMode: mode,

      theme: ThemeData(
        colorScheme: lightScheme,
        useMaterial3: true,
      ),

      darkTheme: ThemeData(
        colorScheme: darkScheme,
        useMaterial3: true,
      ),

      home: DashboardScreen(
        expenses: expenses,
        onToggleTheme: toggleTheme,
        onAddExpense: addExpense,
      ),
    );
  }
}