import 'package:flutter/material.dart';
import 'package:wwm/models/entity_model.dart';

class EntitiesModel extends ChangeNotifier {
  final List<Entity> _entities = [];

  List<Entity> get entities => _entities;

  void addItem(Entity entity) {
    _entities.add(entity);
    notifyListeners();
  }
}
