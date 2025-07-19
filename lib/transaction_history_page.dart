import 'package:flutter/material.dart';

class TransactionHistoryPage extends StatelessWidget {
  const TransactionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final List<Map<String, dynamic>> transactions = [
      {
        'category': 'Makanan',
        'icon': Icons.fastfood,
        'note': 'Makan siang di warteg',
        'amount': -15000,
        'date': 'Hari ini, 12:30'
      },
      {
        'category': 'Gaji',
        'icon': Icons.attach_money,
        'note': 'Gaji bulan Juli',
        'amount': 5000000,
        'date': '18 Juli 2025'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: transactions.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final tx = transactions[index];
          final isIncome = tx['amount'] > 0;
          return ListTile(
            leading: Icon(tx['icon'], color: isIncome ? Colors.green : Colors.red),
            title: Text(tx['category']),
            subtitle: Text('${tx['note']}\n${tx['date']}'),
            isThreeLine: true,
            trailing: Text(
              '${isIncome ? '+' : '-'} Rp ${tx['amount'].abs()}',
              style: TextStyle(
                color: isIncome ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
