import 'package:flutter/material.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _expenseController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Transaction')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // INCOME
            TextField(
              controller: _incomeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Income',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            // EXPENSE
            TextField(
              controller: _expenseController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Expense',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            // CATEGORY
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            // NOTE
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                labelText: 'Note',
                border: OutlineInputBorder(),
              ),
            ),

            const Spacer(),

            // SAVE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final income =
                      double.tryParse(_incomeController.text) ?? 0;
                  final expense =
                      double.tryParse(_expenseController.text) ?? 0;

                  final transaction = {
                    'income': income,
                    'expense': expense,
                    'category': _categoryController.text,
                    'note': _noteController.text,

                    // ✅ FIXED TIME (ALWAYS LOCAL + CORRECT)
                    'date': DateTime.now().toLocal(),
                  };

                  Navigator.pop(context, transaction);
                },
                child: const Text('Save Transaction'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}