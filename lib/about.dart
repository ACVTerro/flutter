import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildHeader(context),
            const SizedBox(height: 12),
            _buildAboutItem(
              context,
              icon: Icons.help_outline_rounded,
              title: 'Help',
              subtitle: 'Learn how to add and review your transactions.',
              onTap: () => _showHelpDialog(context),
            ),
            const SizedBox(height: 12),
            _buildAboutItem(
              context,
              icon: Icons.settings_suggest_outlined,
              title: 'Configuration / Settings',
              subtitle: 'Customize currency, notifications, and display options.',
              onTap: () => _showConfigDialog(context),
            ),
            const SizedBox(height: 12),
            _buildAboutItem(
              context,
              icon: Icons.lightbulb_outline_rounded,
              title: 'Recommendation',
              subtitle: 'Get practical tips to improve savings and budget control.',
              onTap: () => _showRecommendationDialog(context),
            ),
            const SizedBox(height: 12),
            _buildAboutItem(
              context,
              icon: Icons.workspace_premium_outlined,
              title: 'Credits',
              subtitle: 'Meet the TipidBuddy Team.',
              onTap: () => _showCreditsDialog(context),
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
              child: const Icon(Icons.info_outline, color: Color(0xFFA5B4FC)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Help, settings, recommendations, and app credits.',
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

  Widget _buildAboutItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      color: const Color(0xFF151C33),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          leading: Icon(icon, color: const Color(0xFFA5B4FC)),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.chevron_right_rounded),
        ),
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help'),
        content: const Text(
          'To add a transaction:\n'
          '1. Tap "Add Transaction" button.\n'
          '2. Select income or expense.\n'
          '3. Enter amount, choose category, add note (optional), and pick date.\n'
          '4. Tap "Save Transaction".\n\n'
          'To view transactions, go to the "Transactions" tab.\n'
          'Use the search icon to find specific categories.\n\n'
          'Stats page shows your monthly income vs expenses.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }

  void _showConfigDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Settings'),
        content: const Text(
          'TipidBuddy features coming soon:\n'
          '- Change currency (PHP, USD, etc.)\n'
          '- Enable notifications for budget limits\n'
          '- Dark/Light theme toggle\n'
          '- Export data to CSV',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }

  void _showRecommendationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Recommendations'),
        content: const Text(
          '• Track every expense, no matter how small.\n'
          '• Set a monthly budget and stick to it.\n'
          '• Use the 50/30/20 rule: 50% needs, 30% wants, 20% savings.\n'
          '• Review your stats regularly to spot trends.\n'
          '• Save first before spending – automate savings if possible.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }

  void _showCreditsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Credits'),
        content: const Text(
          'TipidBuddy is developed by:\n\n'
          '• John Lei Cueto\n'
          '• Jean Mickel Manalo\n'
          '• Mark Angelo Vergara\n'
          '• Aaron Villacorta\n\n'
          'Built with Flutter.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }
}