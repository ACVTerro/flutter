import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tipidbuddy/add_transaction_page.dart';
import 'package:tipidbuddy/backend/services/transactions_services.dart';
import 'package:tipidbuddy/theme/app_theme.dart';
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
          backgroundColor: Theme.of(context).cardColor,
          title: Text('Add Note', style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color)),
          content: TextField(
            autofocus: true,
            onChanged: (value) => newNote = value,
            decoration: InputDecoration(hintText: 'Type your note here'),
            style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
            ),
            ElevatedButton(
              onPressed: () {
                if (newNote.isNotEmpty) setState(() => _notes.add(newNote));
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 8),
            TabBar(
              controller: _tabController,
              dividerColor: Colors.transparent,
              indicatorColor: isDark ? const Color(0xFFBBBBBB) : Colors.grey,
              unselectedLabelColor: isDark ? Colors.white70 : Colors.grey[600],
              labelColor: isDark ? Colors.white : Colors.black87,
              tabs: const [
                Tab(text: 'Daily'),
                Tab(text: 'Calendar'),
                Tab(text: 'Notes'),
              ],
            ),
            Container(
              color: Theme.of(context).cardColor,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Income
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Income', style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color)),
                      Text(
                        '₱${_totalIncome.toStringAsFixed(2)}',
                        style: const TextStyle(color: AppTheme.incomeGreen, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(width: 32),
                  // Expenses
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Expenses', style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color)),
                      Text(
                        '₱${_totalExpense.toStringAsFixed(2)}',
                        style: const TextStyle(color: AppTheme.expenseRed, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(width: 32),
                  // Total
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Total', style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color)),
                      Text(
                        '₱${(_totalIncome - _totalExpense).toStringAsFixed(2)}',
                        style: TextStyle(
                          color: isDark ? const Color(0xFFBBBBBB) : Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
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
                                color: isDark ? const Color(0xFF2C2C2C) : Colors.grey[200],
                                child: Row(
                                  children: [
                                    Expanded(flex: 2, child: Text('Category', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color))),
                                    Expanded(flex: 3, child: Text('Note', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color))),
                                    Expanded(flex: 2, child: Text('Income', textAlign: TextAlign.right, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color))),
                                    Expanded(flex: 2, child: Text('Expense', textAlign: TextAlign.right, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color))),
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
                                    style: TextStyle(fontSize: 12, color: isDark ? Colors.white70 : Colors.grey[600]),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                                  child: Row(
                                    children: [
                                      Expanded(flex: 2, child: Text(categoryName, style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color))),
                                      Expanded(flex: 3, child: Text(note, style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color))),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          isIncome ? amount.toStringAsFixed(2) : '',
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(color: AppTheme.incomeGreen),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          !isIncome ? amount.toStringAsFixed(2) : '',
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(color: AppTheme.expenseRed),
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
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      headerMargin: const EdgeInsets.only(bottom: 10),
                      titleTextStyle: TextStyle(color: Theme.of(context).textTheme.titleMedium?.color),
                    ),
                    calendarStyle: CalendarStyle(
                      weekendTextStyle: TextStyle(color: isDark ? Colors.white70 : Colors.grey[600]),
                      defaultTextStyle: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: isDark ? Colors.white70 : Colors.grey[600]),
                      weekendStyle: TextStyle(color: isDark ? Colors.white70 : Colors.grey[600]),
                    ),
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: _notes.isEmpty
                            ? Center(child: Text('No notes yet', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)))
                            : ListView.builder(
                                itemCount: _notes.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Icon(Icons.note, color: isDark ? const Color(0xFFBBBBBB) : Colors.grey[700]),
                                    title: Text(_notes[index], style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
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
                      if (result == true) _loadData();
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transactions',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Manage daily entries, calendar, and notes.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white70
                      : Colors.grey[600],
                ),
          ),
        ],
      ),
    );
  }
}