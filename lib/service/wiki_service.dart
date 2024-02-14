import 'package:http/http.dart' as http;
import 'dart:convert';

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
