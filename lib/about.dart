import 'package:flutter/material.dart';
import 'package:tipidbuddy/settings_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildHeader(context),
            const SizedBox(height: 12),
            // Configuration / Settings (now first)
            _buildAboutItem(
              context,
              icon: Icons.settings_suggest_outlined,
              title: 'Configuration / Settings',
              subtitle: 'Customize currency, notifications, and display options.',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage())),
            ),
            const SizedBox(height: 12),
            // Help (now second)
            _buildAboutItem(
              context,
              icon: Icons.help_outline_rounded,
              title: 'Help',
              subtitle: 'Learn how to add and review your transactions.',
              onTap: () => _showHelpDialog(context),
            ),
            const SizedBox(height: 12),
            // Recommendation
            _buildAboutItem(
              context,
              icon: Icons.lightbulb_outline_rounded,
              title: 'Recommendation',
              subtitle: 'Get practical tips to improve savings and budget control.',
              onTap: () => _showRecommendationDialog(context),
            ),
            const SizedBox(height: 12),
            // Credits
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
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Help, settings, recommendations, and app credits.',
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

  Widget _buildAboutItem(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return Card(
      elevation: 0,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          leading: Icon(icon, color: Theme.of(context).iconTheme.color),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.titleMedium?.color)),
          subtitle: Text(subtitle, style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color)),
          trailing: Icon(Icons.chevron_right_rounded, color: Theme.of(context).iconTheme.color),
        ),
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        title: Text('Help', style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color)),
        content: Text(
          'To add a transaction:\n'
          '1. Tap "Add Transaction" button.\n'
          '2. Select income or expense.\n'
          '3. Enter amount, choose category, add note (optional), and pick date.\n'
          '4. Tap "Save Transaction".\n\n'
          'To view transactions, go to the "Transactions" tab.\n'
          'Use the search icon to find specific categories.\n\n'
          'Stats page shows your monthly income vs expenses.',
          style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
          ),
        ],
      ),
    );
  }

  void _showRecommendationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        title: Text('Recommendations', style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color)),
        content: Text(
          '• Track every expense, no matter how small.\n'
          '• Set a monthly budget and stick to it.\n'
          '• Use the 50/30/20 rule: 50% needs, 30% wants, 20% savings.\n'
          '• Review your stats regularly to spot trends.\n'
          '• Save first before spending – automate savings if possible.',
          style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
          ),
        ],
      ),
    );
  }

  void _showCreditsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        title: Text('Credits', style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color)),
        content: Text(
          'TipidBuddy is developed by:\n\n'
          '• John Lei Cueto\n'
          '• Jean Mickel Manalo\n'
          '• Mark Angelo Vergara\n'
          '• Aaron Villacorta\n\n'
          'Built with Flutter.',
          style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
          ),
        ],
      ),
    );
  }
}