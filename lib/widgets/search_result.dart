import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
  final String title;
  final String subtitle;

  // Constructor with named parameters, title and leading are required
  const SearchResult({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title), // Display title text
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right_outlined),
    );
  }
}
