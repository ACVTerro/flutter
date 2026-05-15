import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tipidbuddy/search.dart';
import 'package:tipidbuddy/add_transaction_page.dart';
import 'package:tipidbuddy/backend/services/transactions_services.dart';
import 'package:intl/intl.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> _transactions = [];
  double _totalIncome = 0;
  double _totalExpense = 0;
  bool _loading = true;

  final List<String> _dailyItems = [
    'Salary',
    'Freelance',
    'Groceries',
    'Rent',
    'Utilities',
  ];
  final List<String> _notes = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadData();
  }

  Future<void> _loadData() async {
    if (!mounted) return;
    setState(() => _loading = true);
    final data = await TransactionServices.getAllbyCategories();
    double income = 0, expense = 0;
    for (var t in data) {
      if (t['type'] == 'income') {
        income += t['amount'];
      } else {
        expense += t['amount'];
      }
    }
    if (mounted) {
      setState(() {
        _transactions = data;
        _totalIncome = income;
        _totalExpense = expense;
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addNoteDialog() {
    String newNote = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Note'),
          content: TextField(
            autofocus: true,
            onChanged: (value) {
              newNote = value;
            },
            decoration: const InputDecoration(hintText: 'Type your note here'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (newNote.isNotEmpty) {
                  setState(() {
                    _notes.add(newNote);
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 8),
            TabBar(
              controller: _tabController,
              dividerColor: Colors.transparent,
              indicatorColor: const Color(0xFFA5B4FC),
              unselectedLabelColor: Colors.white70,
              labelColor: Colors.white,
              tabs: const [
                Tab(text: 'Daily'),
                Tab(text: 'Calendar'),
                Tab(text: 'Notes'),
              ],
            ),
            Container(
              color: const Color(0xFF151C33),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text('Income', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      Text(
                        '₱${_totalIncome.toStringAsFixed(2)}',
                        style: const TextStyle(color: Color(0xFF22C55E), fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Expenses', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      Text(
                        '₱${_totalExpense.toStringAsFixed(2)}',
                        style: const TextStyle(color: Color(0xFFEF4444), fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Total', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      Text(
                        '₱${(_totalIncome - _totalExpense).toStringAsFixed(2)}',
                        style: const TextStyle(color: Color(0xFFA5B4FC), fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _loading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: _transactions.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Container(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                color: const Color(0xFF1E2745),
                                child: const Row(
                                  children: [
                                    Expanded(flex: 2, child: Text('Category')),
                                    Expanded(flex: 3, child: Text('Note')),
                                    Expanded(flex: 2, child: Text('Income', textAlign: TextAlign.right)),
                                    Expanded(flex: 2, child: Text('Expense', textAlign: TextAlign.right)),
                                  ],
                                ),
                              );
                            }
                            final t = _transactions[index - 1];
                            final isIncome = t['type'] == 'income';
                            final amount = t['amount'];
                            final date = DateTime.parse(t['transact_date']);
                            final categoryName = t['category_name'] ?? '';
                            final note = t['note'] ?? '';

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  child: Text(
                                    DateFormat('MMMM d, yyyy').format(date),
                                    style: const TextStyle(fontSize: 12, color: Colors.white70),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                                  child: Row(
                                    children: [
                                      Expanded(flex: 2, child: Text(categoryName)),
                                      Expanded(flex: 3, child: Text(note)),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          isIncome ? amount.toStringAsFixed(2) : '',
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(color: Color(0xFF22C55E)),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          !isIncome ? amount.toStringAsFixed(2) : '',
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(color: Color(0xFFEF4444)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                  TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: DateTime.now(),
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: _notes.isEmpty
                            ? const Center(child: Text('No notes yet'))
                            : ListView.builder(
                                itemCount: _notes.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: const Icon(Icons.note),
                                    title: Text(_notes[index]),
                                  );
                                },
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.add),
                            label: const Text('Add Note'),
                            onPressed: _addNoteDialog,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (_tabController.index == 0 || _tabController.index == 1)
              Padding(
                padding: const EdgeInsets.only(bottom: 8, top: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AddTransactionPage()),
                      );
                      if (result == true) {
                        _loadData();
                      }
                    },
                    child: const Text('Add Transaction'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0xFF151C33),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2745),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.receipt_long_outlined,
                color: Color(0xFFA5B4FC),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transactions',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Manage daily entries, calendar, and notes.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                if (_tabController.index == 0) {
                  showSearch(
                    context: context,
                    delegate: DailySearchDelegate(dailyItems: _dailyItems),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}