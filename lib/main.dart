import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'transaction_history_page.dart';
import 'add_transaction_page.dart';

// Data global untuk demo (bisa nanti ganti dengan DB atau state management)
double currentBalance = 1575000;

List<Map<String, dynamic>> transactions = [
  {
    'category': 'Makanan',
    'icon': Icons.fastfood,
    'note': 'Makan siang di warteg',
    'amount': -15000.0,
    'date': '2025-07-19',
    'type': 'Pengeluaran',
  },
  {
    'category': 'Gaji',
    'icon': Icons.attach_money,
    'note': 'Gaji bulan Juli',
    'amount': 5000000.0,
    'date': '2025-07-18',
    'type': 'Pemasukan',
  },
];

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
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardPage(),
        '/history': (context) => const TransactionHistoryPage(),
        '/addTransaction': (context) => const AddTransactionPage(),
      },
    );
  }
}
