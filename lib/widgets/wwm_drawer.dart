import 'package:flutter/material.dart';

class WWMDrawer extends StatelessWidget {
  const WWMDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // // Update the state of the app
              // // ...
              // // Then close the drawer
              // Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
