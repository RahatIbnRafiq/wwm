import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wwm/models/entities_model.dart';
import 'pages/homepage.dart';
import 'theme.dart';

import 'package:wwm/constants.dart' as constants;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EntitiesModel(),
      child: MaterialApp(
        title: constants.appTitle,
        theme: myTheme,
        home: const Homepage(),
      ),
    );
  }
}
