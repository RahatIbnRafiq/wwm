// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wwm/constants.dart' as constants;
import 'package:wwm/sensitive.dart' as sensitive;

// class Name {
//   final String firstname;
//   final String lastname;

//   const Name({
//     required this.firstname,
//     required this.lastname,
//   });

//   factory Name.fromJson(Map<String, dynamic> json) {
//     return Name(firstname: json['first'], lastname: json['last']);
//   }
// }

// class User {
//   final String email;
//   final String picture;
//   final Name name;

//   const User({
//     required this.email,
//     required this.picture,
//     required this.name,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       email: json['email'],
//       picture: json['picture']['medium'],
//       name: Name.fromJson(json['name']),
//     );
//   }
// }

class Entity {
  final String title;
  final String shortDescription;
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
    print("wikiresponse: 1");
    var wikiResponse = await http.get(url, headers: {
      'User-Agent': sensitive.appName,
      'Authorization': sensitive.accessToken,
    });
    print("wikiresponse: 2");

    final List<Entity> searchResults = [];

    if (wikiResponse.statusCode == 200) {
      final data = json.decode(wikiResponse.body);
      for (var entry in data['pages']) {
        try {
          searchResults.add(Entity.fromJson(entry));
          print("wikiresponse: 3");
        } catch (exception) {
          print("this is where bad thing happened: $exception");
          print(entry);
        }
      }
      print("wikiresponse: 4");
      return searchResults;
    } else {
      print("wikiresponse: 5");
      throw Exception('HTTP Request Failed!');
    }

    // final response = await http.get(
    //     Uri.parse("https://randomuser.me/api/?results=30&seed=$searchString"));

    // if (response.statusCode == 200) {
    //   final data = jsonDecode(response.body);

    //   final List<User> userList = [];
    //   for (var entry in data['results']) {
    //     userList.add(User.fromJson(entry));
    //   }
    //   return userList;
    // } else {
    //   throw Exception('HTTP Request Failed!');
    // }
  }
}
