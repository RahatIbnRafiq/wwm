import 'package:flutter/material.dart';

import 'package:wwm/constants.dart' as constants;
import 'package:wwm/pages/see_all_entities.dart';

class WWMDrawer extends StatelessWidget {
  const WWMDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Text(constants.drawerHeader),
          ),
          ListTile(
            title: const Text(constants.seeAllEntities),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SeeAllEntities()));
            },
          ),
          ListTile(
            title: const Text(constants.yourToursString),
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
