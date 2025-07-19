import 'package:flutter/material.dart';
import 'dashboard_page.dart';         // Halaman 1
import 'add_transaction_page.dart';  // Halaman 2
import 'transaction_history_page.dart'; // Halaman 3

void main() {
  runApp(const DompetKuApp());
}

class DompetKuApp extends StatelessWidget {
  const DompetKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DompetKu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardPage(),
        '/addTransaction': (context) => const AddTransactionPage(),
        '/history': (context) => const TransactionHistoryPage(),
      },
    );
  }
}
