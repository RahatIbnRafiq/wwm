import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wwm/constants.dart' as constants;
import 'package:wwm/sensitive.dart' as sensitive;

class Name {
  final String firstname;
  final String lastname;

  const Name({
    required this.firstname,
    required this.lastname,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(firstname: json['first'], lastname: json['last']);
  }
}

class User {
  final String email;
  final String picture;
  final Name name;

  const User({
    required this.email,
    required this.picture,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      picture: json['picture']['medium'],
      name: Name.fromJson(json['name']),
    );
  }
}

class WikiService {
  Future<List<User>> getUser(String searchString) async {
    var url = Uri.https(constants.wikimediaBaseURL, constants.searchEndpoint, {
      'q': searchString,
      //'limit': constants.numberOfResults,
    });
    var wikiResponse = await http.get(url, headers: {
      'User-Agent': sensitive.appName,
      'Authorization': sensitive.accessToken,
    });

    if (wikiResponse.statusCode == 200) {
      print(json.decode(wikiResponse.body));
    } else {
      print('Failed to load data from Wikimedia: ' +
          wikiResponse.statusCode.toString());
    }

    final response = await http.get(
        Uri.parse("https://randomuser.me/api/?results=30&seed=$searchString"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List<User> userList = [];
      for (var entry in data['results']) {
        userList.add(User.fromJson(entry));
      }
      return userList;
    } else {
      throw Exception('HTTP Request Failed!');
    }
  }
}
