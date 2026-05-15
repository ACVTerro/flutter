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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Help, settings, recommendations, and app credits.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white70,
            ),
          ),
        ],
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
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          leading: Icon(icon, color: const Color(0xFFBBBBBB)),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
          subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
          trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFFBBBBBB)),
        ),
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('Help', style: TextStyle(color: Colors.white)),
        content: const Text(
          'To add a transaction:\n'
          '1. Tap "Add Transaction" button.\n'
          '2. Select income or expense.\n'
          '3. Enter amount, choose category, add note (optional), and pick date.\n'
          '4. Tap "Save Transaction".\n\n'
          'To view transactions, go to the "Transactions" tab.\n'
          'Use the search icon to find specific categories.\n\n'
          'Stats page shows your monthly income vs expenses.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Color(0xFFBBBBBB))),
          ),
        ],
      ),
    );
  }

  void _showConfigDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
        content: const Text(
          'TipidBuddy features coming soon:\n'
          '- Change currency (PHP, USD, etc.)\n'
          '- Enable notifications for budget limits\n'
          '- Dark/Light theme toggle\n'
          '- Export data to CSV',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Color(0xFFBBBBBB))),
          ),
        ],
      ),
    );
  }

  void _showRecommendationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('Recommendations', style: TextStyle(color: Colors.white)),
        content: const Text(
          '• Track every expense, no matter how small.\n'
          '• Set a monthly budget and stick to it.\n'
          '• Use the 50/30/20 rule: 50% needs, 30% wants, 20% savings.\n'
          '• Review your stats regularly to spot trends.\n'
          '• Save first before spending – automate savings if possible.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Color(0xFFBBBBBB))),
          ),
        ],
      ),
    );
  }

  void _showCreditsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('Credits', style: TextStyle(color: Colors.white)),
        content: const Text(
          'TipidBuddy is developed by:\n\n'
          '• John Lei Cueto\n'
          '• Jean Mickel Manalo\n'
          '• Mark Angelo Vergara\n'
          '• Aaron Villacorta\n\n'
          'Built with Flutter and ❤️.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Color(0xFFBBBBBB))),
          ),
        ],
      ),
    );
  }
}