// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html/parser.dart' as parser;

import 'package:wwm/constants.dart' as constants;
import 'package:wwm/sensitive.dart' as sensitive;
import 'package:wwm/utility/utility.dart';

class Entity {
  final String? title;
  final String? shortDescription;
  final String wikiKey;
  String wikiTitle = "";
  String fullDescription = "";

  Entity({
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
  Future<void> getEntityDetails(Entity entity) async {
    await Future.delayed(const Duration(seconds: 2));
    final url = Uri.parse(constants.rootWikiUrl + entity.wikiKey);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      entity.wikiTitle = document.getElementById("firstHeading")!.text.trim();
      var paragraphs = document.getElementsByTagName("p");
      int numWikiParagraphs = paragraphs.length < constants.numWikiParagraphs
          ? paragraphs.length
          : constants.numWikiParagraphs;
      for (int i = 0; i < numWikiParagraphs; i++) {
        entity.fullDescription += paragraphs[i].text.trim();
      }
    } else {
      print("Something bad has happened! response code: " +
          response.statusCode.toString());
    }
    entity.fullDescription = Utility.filterDescription(entity.fullDescription);
    print(entity.fullDescription);
  }

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
