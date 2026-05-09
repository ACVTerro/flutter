import 'package:flutter/material.dart';
import 'package:tipidbuddy/backend/services/transactions_services.dart';
import 'package:intl/intl.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  List<_MonthlyStat> _monthlyStats = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    List<_MonthlyStat> stats = [];
    final now = DateTime.now();
    for (int i = 5; i >= 0; i--) {
      final date = DateTime(now.year, now.month - i, 1);
      final monthStr = DateFormat('yyyy-MM').format(date);
      final summary = await TransactionServices.monthlySummary(monthStr);
      stats.add(_MonthlyStat(
        month: DateFormat('MMM').format(date),
        income: summary['income'] ?? 0.0,
        expenses: summary['expense'] ?? 0.0,
      ));
    }
    if (mounted) {
      setState(() {
        _monthlyStats = stats;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 12),
                  _buildGraphCard(context),
                  const SizedBox(height: 16),
                  _buildMonthlyTable(),
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
                Icons.bar_chart_rounded,
                color: Color(0xFFA5B4FC),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Statistics',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Visualize monthly income and spending trends.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGraphCard(BuildContext context) {
    if (_monthlyStats.isEmpty) {
      return const Card(
        color: Color(0xFF151C33),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: Text('No data yet')),
        ),
      );
    }
    final maxValue = _monthlyStats
        .map((entry) => entry.income > entry.expenses ? entry.income : entry.expenses)
        .reduce((a, b) => a > b ? a : b);

    return Card(
      elevation: 0,
      color: const Color(0xFF151C33),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Income vs Expenses',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 180,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: _monthlyStats
                    .map((entry) => Expanded(
                          child: _MonthBars(entry: entry, maxValue: maxValue),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                _LegendDot(color: Color(0xFF22C55E), label: 'Income'),
                SizedBox(width: 14),
                _LegendDot(color: Color(0xFFEF4444), label: 'Expenses'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyTable() {
    return Card(
      elevation: 0,
      color: const Color(0xFF151C33),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const _TableRow(
              month: 'Month',
              income: 'Income',
              expenses: 'Expenses',
              total: 'Total',
              isHeader: true,
            ),
            const Divider(height: 14, color: Color(0xFF1E2745)),
            ..._monthlyStats.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _TableRow(
                  month: entry.month,
                  income: 'P${entry.income.toStringAsFixed(0)}',
                  expenses: 'P${entry.expenses.toStringAsFixed(0)}',
                  total: 'P${entry.total.toStringAsFixed(0)}',
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _TableRow extends StatelessWidget {
  final String month;
  final String income;
  final String expenses;
  final String total;
  final bool isHeader;

  const _TableRow({
    required this.month,
    required this.income,
    required this.expenses,
    required this.total,
    this.isHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle = TextStyle(
      fontWeight: isHeader ? FontWeight.w700 : FontWeight.w500,
      color: isHeader ? Colors.white : Colors.white70,
    );

    return Row(
      children: [
        Expanded(child: Text(month, style: baseStyle)),
        Expanded(
          child: Text(
            income,
            style: baseStyle.copyWith(
              color: isHeader ? Colors.white : const Color(0xFF22C55E),
            ),
          ),
        ),
        Expanded(
          child: Text(
            expenses,
            style: baseStyle.copyWith(
              color: isHeader ? Colors.white : const Color(0xFFEF4444),
            ),
          ),
        ),
        Expanded(
          child: Text(
            total,
            textAlign: TextAlign.end,
            style: baseStyle.copyWith(
              color: isHeader ? Colors.white : const Color(0xFFA5B4FC),
            ),
          ),
        ),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}

class _MonthBars extends StatelessWidget {
  final _MonthlyStat entry;
  final double maxValue;

  const _MonthBars({required this.entry, required this.maxValue});

  @override
  Widget build(BuildContext context) {
    // Use absolute value of maxValue for scaling, and clamp ratios between 0 and 1
    final positiveMax = maxValue.abs();
    double incomeRatio = 0.0;
    double expenseRatio = 0.0;
    if (positiveMax > 0) {
      incomeRatio = (entry.income / positiveMax).clamp(0.0, 1.0);
      expenseRatio = (entry.expenses / positiveMax).clamp(0.0, 1.0);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 12,
                height: 130 * incomeRatio,
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 12,
                height: 130 * expenseRatio,
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(entry.month),
      ],
    );
  }
}

class _MonthlyStat {
  final String month;
  final double income;
  final double expenses;

  const _MonthlyStat({required this.month, required this.income, required this.expenses});

  double get total => income - expenses;
}