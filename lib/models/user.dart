import 'package:flutter/cupertino.dart';

class User {
  final int id;
  final String email;
  final String name;
  final String token;

  User({@required this.id, @required this.email, @required this.name, @required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], name: json['name'], email: json['email'], token: json['token']);
  }

  int getId() {
    return this.id;
  }

  String getEmail() {
    return this.email;
  }

  String getName() {
    return this.name;
  }
}
