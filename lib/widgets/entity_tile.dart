import 'package:flutter/material.dart';

import 'package:wwm/constants.dart' as constants;

class EntityTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onAdd;

  // Constructor with named parameters, title and leading are required
  const EntityTile(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.onAdd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title), // Display title text
      subtitle: Text(subtitle),
      trailing: IconButton(
        icon: const Icon(Icons.playlist_add),
        onPressed: onAdd,
        tooltip: constants.addToPlaylist,
      ),
    );
  }
}
