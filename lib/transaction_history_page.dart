import 'package:flutter/material.dart';
import 'main.dart';

class TransactionHistoryPage extends StatelessWidget {
  const TransactionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            leading: CircleAvatar(
              backgroundColor: isIncome ? Colors.green[100] : Colors.red[100],
              child: Icon(tx['icon'], color: isIncome ? Colors.green : Colors.red),
            ),
            title: Text(tx['category'],
                style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text('${tx['note']}\n${tx['date']}'),
            isThreeLine: true,
            trailing: Text(
              '${isIncome ? '+' : '-'} Rp ${tx['amount'].abs().toStringAsFixed(0)}',
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
