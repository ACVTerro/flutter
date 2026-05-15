import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tipidbuddy/providers/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).cardColor,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Switch between light and dark theme'),
            value: isDark,
            onChanged: (value) {
              themeProvider.setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
            },
            secondary: Icon(
              isDark ? Icons.dark_mode : Icons.light_mode,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white70
                  : Colors.black54,
            ),
          ),
          const Divider(),
          const ListTile(
            title: Text('App Version'),
            subtitle: Text('1.0.0'),
          ),
        ],
      ),
    );
  }
}