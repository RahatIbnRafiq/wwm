// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wwm/constants.dart' as constants;
import 'package:wwm/sensitive.dart' as sensitive;

class Entity {
  final String? title;
  final String? shortDescription;
  final String wikiKey;

  const Entity({
    required this.title,
    required this.shortDescription,
    required this.wikiKey,
  });

  factory Entity.fromJson(Map<String, dynamic> json) {
    return Entity(
      title: json['title'],
      shortDescription: json['description'],
      wikiKey: json['key'],
    );
  }
}

class WikiService {
  Future<List<Entity>> getEntities(String searchString) async {
    var url = Uri.https(constants.wikimediaBaseURL, constants.searchEndpoint, {
      'q': searchString,
    });
    var wikiResponse = await http.get(url, headers: {
      'User-Agent': sensitive.appName,
      'Authorization': sensitive.accessToken,
    });

    final List<Entity> searchResults = [];

    if (wikiResponse.statusCode == 200) {
      final data = json.decode(wikiResponse.body);
      for (var entry in data['pages']) {
        try {
          searchResults.add(Entity.fromJson(entry));
        } catch (exception) {
          print("this is where bad thing happened: $exception");
        }
      }
      return searchResults;
    } else {
      throw Exception('HTTP Request Failed!');
    }
  }
}
