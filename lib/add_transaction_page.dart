import 'package:flutter/material.dart';
import 'package:tipidbuddy/backend/models/categories.dart';
import 'package:tipidbuddy/backend/models/transactions.dart';
import 'package:tipidbuddy/backend/services/categories_services.dart';
import 'package:tipidbuddy/backend/services/transactions_services.dart';
import 'package:intl/intl.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  String _type = 'expense';
  CategoriesModel? _selectedCategory;
  DateTime _date = DateTime.now();

  List<CategoriesModel> _incomeCategories = [];
  List<CategoriesModel> _expenseCategories = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _loadCategories() async {
    final all = await CategoryServices.getAll();
    if (mounted) {
      setState(() {
        _incomeCategories = all.where((c) => c.type == 'income').toList();
        _expenseCategories = all.where((c) => c.type == 'expense').toList();
        _loading = false;
      });
    }
  }

  Future<void> _saveTransaction() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a category')),
      );
      return;
    }

    final amount = double.tryParse(_amountController.text) ?? 0;
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    final transaction = TransactionsModel(
      amount: amount,
      categoryID: _selectedCategory!.id!,
      note: _noteController.text.isEmpty ? null : _noteController.text,
      date: DateFormat('yyyy-MM-dd').format(_date),
    );

    await TransactionServices.insert(transaction);
    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Transaction')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SegmentedButton<String>(
                      segments: const [
                        ButtonSegment(value: 'expense', label: Text('Expense'), icon: Icon(Icons.remove_circle_outline)),
                        ButtonSegment(value: 'income', label: Text('Income'), icon: Icon(Icons.add_circle_outline)),
                      ],
                      selected: {_type},
                      onSelectionChanged: (Set<String> newSelection) {
                        setState(() {
                          _type = newSelection.first;
                          _selectedCategory = null;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Amount',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.white70),
                      ),
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Enter amount';
                        if (double.tryParse(value) == null) return 'Enter valid number';
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<CategoriesModel>(
                      value: _selectedCategory,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.white70),
                      ),
                      dropdownColor: const Color(0xFF1E1E1E),
                      style: const TextStyle(color: Colors.white),
                      items: (_type == 'income' ? _incomeCategories : _expenseCategories).map((c) {
                        return DropdownMenuItem(value: c, child: Text(c.label));
                      }).toList(),
                      onChanged: (value) => setState(() => _selectedCategory = value),
                      validator: (value) => value == null ? 'Select category' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _noteController,
                      decoration: const InputDecoration(
                        labelText: 'Note (optional)',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.white70),
                      ),
                      style: const TextStyle(color: Colors.white),
                      maxLines: null,
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      title: const Text('Date', style: TextStyle(color: Colors.white70)),
                      subtitle: Text(DateFormat('MMMM d, yyyy').format(_date), style: const TextStyle(color: Colors.white)),
                      trailing: const Icon(Icons.calendar_today, color: Color(0xFFBBBBBB)),
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _date,
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) setState(() => _date = picked);
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveTransaction,
                        child: const Text('Save Transaction'),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
    );
  }
}