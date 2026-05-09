import 'package:flutter/material.dart';

class DailySearchDelegate extends SearchDelegate<String> {
  final List<String> dailyItems;

  DailySearchDelegate({required this.dailyItems});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = dailyItems
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView(
      children: results
          .map(
            (item) => ListTile(
              title: Text(item),
              onTap: () {
                close(context, item);
              },
            ),
          )
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = dailyItems
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView(
      children: suggestions
          .map(
            (item) => ListTile(
              title: Text(item),
              onTap: () {
                query = item;
                showResults(context);
              },
            ),
          )
          .toList(),
    );
  }
}