import 'package:flutter/material.dart';
import 'main.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  String _type = 'Pengeluaran';
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _saveTransaction() {
    final amount = double.tryParse(_amountController.text);
    final category = _categoryController.text.trim();

    if (amount == null || amount <= 0 || category.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan jumlah dan kategori yang valid')),
      );
      return;
    }

    final isIncome = _type == 'Pemasukan';
    final signedAmount = isIncome ? amount : -amount;

    currentBalance += signedAmount;

    IconData icon = Icons.receipt;
    // Sederhanakan pemilihan icon
    if (category.toLowerCase().contains('makan')) {
      icon = Icons.fastfood;
    } else if (category.toLowerCase().contains('transport')) {
      icon = Icons.directions_car;
    } else if (category.toLowerCase().contains('gaji')) {
      icon = Icons.attach_money;
    } else if (category.toLowerCase().contains('tagihan')) {
      icon = Icons.receipt_long;
    } else {
      icon = isIncome ? Icons.arrow_downward : Icons.arrow_upward;
    }

    transactions.insert(0, {
      'category': category,
      'icon': icon,
      'note': _noteController.text.trim(),
      'amount': signedAmount,
      'date': _selectedDate.toString().split(' ')[0],
      'type': _type,
    });

    Navigator.pop(context);
  }

  void _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Transaksi'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Pilihan tipe transaksi dengan ChoiceChip
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ['Pengeluaran', 'Pemasukan'].map((type) {
                final selected = _type == type;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ChoiceChip(
                    label: Text(type,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    selected: selected,
                    onSelected: (_) => setState(() => _type = type),
                    selectedColor: Colors.blueAccent,
                    backgroundColor: Colors.grey.shade200,
                    labelStyle: TextStyle(
                        color: selected ? Colors.white : Colors.black),
                    elevation: 3,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Input jumlah
            TextField(
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Jumlah (Rp)',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.money),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
            const SizedBox(height: 20),

            // Input kategori bebas ketik
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(
                labelText: 'Kategori',
                hintText: 'Masukkan kategori',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.category),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
            const SizedBox(height: 20),

            // Catatan opsional
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Catatan (Opsional)',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.note),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 20),

            // Pilih tanggal dengan tombol
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tanggal: ${_selectedDate.toLocal().toString().split(' ')[0]}',
                    style: const TextStyle(fontWeight: FontWeight.w500)),
                ElevatedButton.icon(
                  onPressed: _selectDate,
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Pilih Tanggal'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Tombol simpan
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveTransaction,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text('Simpan Transaksi',
                      style: TextStyle(fontSize: 18)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  elevation: 5,
                  shadowColor: Colors.blueAccent.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
