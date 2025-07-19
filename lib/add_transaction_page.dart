import 'package:flutter/material.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  String _type = 'Pengeluaran';
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String _category = 'Makanan';
  DateTime _selectedDate = DateTime.now();

  final List<String> _categories = ['Makanan', 'Transportasi', 'Gaji', 'Tagihan'];

  void _saveTransaction() {
    // Simulasi simpan data
    Navigator.pop(context); // Kembali ke Dashboard
    // Harusnya di sini ada update data/saldo
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Transaksi'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Pilihan tipe transaksi
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ['Pengeluaran', 'Pemasukan'].map((type) {
                final isSelected = _type == type;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ChoiceChip(
                    label: Text(type),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _type = type),
                    selectedColor: Colors.blueAccent,
                    labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            // Nominal
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Jumlah (Rp)'),
            ),
            const SizedBox(height: 16),
            // Kategori
            DropdownButtonFormField<String>(
              value: _category,
              items: _categories
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (value) => setState(() => _category = value!),
              decoration: const InputDecoration(labelText: 'Kategori'),
            ),
            const SizedBox(height: 16),
            // Catatan
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(labelText: 'Catatan (Opsional)'),
            ),
            const SizedBox(height: 16),
            // Tanggal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tanggal: ${_selectedDate.toLocal().toString().split(' ')[0]}'),
                TextButton(
                  onPressed: _selectDate,
                  child: const Text('Pilih Tanggal'),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _saveTransaction,
              child: const Text('Simpan'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
