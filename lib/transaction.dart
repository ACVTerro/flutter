import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tipidbuddy/search.dart';
import 'package:tipidbuddy/add_transaction_page.dart';
import 'package:intl/intl.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _dailyItems = [
    'Salary',
    'Freelance',
    'Groceries',
    'Rent',
    'Utilities',
  ];

  final List<String> _notes = [];
  final List<Map<String, dynamic>> _transactions = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Income: 0', style: TextStyle(color: Color(0xFF22C55E))),
                  Text('Expenses: 0', style: TextStyle(color: Color(0xFFEF4444))),
                  Text('Total: 0'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                    ListView.builder(
                        itemCount: _transactions.length + 1,
                        itemBuilder: (context, index) {
                          // 🔵 HEADER ROW
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
                          final date = t['date'];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 🔵 DATE (above row)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Text(
                                  DateFormat('MMMM d, yyyy  |  h:mm a')
                                            .format(date.toLocal())
                                            .replaceAll('AM', 'am')
                                            .replaceAll('PM', 'pm'),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),

                              // 🔵 TRANSACTION ROW
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                                child: Row(
                                  children: [
                                    Expanded(flex: 2, child: Text(t['category'] ?? '')),
                                    Expanded(flex: 3, child: Text(t['note'] ?? '')),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        (t['income'] ?? 0) > 0 ? t['income'].toString() : '',
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(color: Color(0xFF22C55E)),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        (t['expense'] ?? 0) > 0 ? t['expense'].toString() : '',
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
                        MaterialPageRoute(
                          builder: (context) => const AddTransactionPage(),
                        ),
                      );

                      if (result != null) {
                        setState(() {
                          _transactions.add(result);
                        });
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
