import 'package:flutter/material.dart';
import 'main.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final income = transactions
        .where((t) => t['amount'] > 0)
        .fold(0.0, (sum, t) => sum + t['amount']);
    final expense = transactions
        .where((t) => t['amount'] < 0)
        .fold(0.0, (sum, t) => sum + t['amount'].abs());

    return Scaffold(
      appBar: AppBar(
        title: const Text('DompetKu'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Saldo Saat Ini',
                style: TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 8),
            Text('Rp ${currentBalance.toStringAsFixed(0)}',
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ringkasan Bulanan',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Pemasukan',
                            style: TextStyle(color: Colors.green)),
                        Text('+ Rp ${income.toStringAsFixed(0)}',
                            style: const TextStyle(color: Colors.green)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Pengeluaran',
                            style: TextStyle(color: Colors.red)),
                        Text('- Rp ${expense.toStringAsFixed(0)}',
                            style: const TextStyle(color: Colors.red)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: income + expense == 0
                          ? 0
                          : expense / (income + expense),
                      backgroundColor: Colors.green[100],
                      color: Colors.redAccent,
                      minHeight: 8,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/history').then((_) => _refresh()),
                child: const Text('Lihat Semua Riwayat',
                    style: TextStyle(decoration: TextDecoration.underline)),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(context, '/addTransaction').then((_) => _refresh()),
        tooltip: 'Tambah Transaksi',
        child: const Icon(Icons.add),
      ),
    );
  }
}
