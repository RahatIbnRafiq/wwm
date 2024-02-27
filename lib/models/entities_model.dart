import 'package:flutter/material.dart';
import 'package:wwm/models/entity_model.dart';

class EntitiesModel extends ChangeNotifier {
  final Map<String, Entity> _entities = {};

  Map<String, Entity> get entities => _entities;

  void addItem(Entity entity) {
    if (_entities.containsKey(entity.wikiKey)) {
    } else {
      // Add a new item if it does not exist
      _entities[entity.wikiKey] = entity;
    }
    notifyListeners();
  }

  bool isAdded(Entity entity) {
    return _entities.containsKey(entity.wikiKey);
  }
}
