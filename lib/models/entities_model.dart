import 'package:flutter/material.dart';

class EntitiesModel extends ChangeNotifier {
  final List<String> _entities = [];

  List<String> get items => _entities;

  void addItem(String item) {
    _entities.add(item);
    notifyListeners();
  }
}
