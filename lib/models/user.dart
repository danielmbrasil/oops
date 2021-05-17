import 'package:flutter/cupertino.dart';

class User {
  final String email;
  final String name;
  final String token;

  User({@required this.email, @required this.name, @required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['name'], email: json['email'], token: json['token']);
  }

  String getEmail() {
    return this.email;
  }

  String getName() {
    return this.name;
  }
}
