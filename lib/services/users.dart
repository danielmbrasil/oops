import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oops/models/user.dart';
import 'package:http/http.dart' as http;

class UsersService {
  String name = '';
  String email = '';

  UsersService({this.name, this.email});

  Future<dynamic> fetchUser() async {
    try {
      // get token and user_id
      final _storage = new FlutterSecureStorage();
      String _token = await _storage.read(key: 'jwt');

      final _url = Uri.parse('http://10.0.2.2:3000/api/users/user');

      final response = await http.get(_url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': _token
      });

      if (response.statusCode == 200) {
        var rBody = jsonDecode(response.body);
        this.name = rBody['data']['attributes']['name'];
        this.email = rBody['data']['attributes']['email'];

        final userData = {
          'name': this.name,
          'email': this.email,
          'token': _token
        };

        return User.fromJson(userData);
      } else {
        throw Exception('Some error ocurred');
      }
    } catch (e) {
      throw Exception('Some error ocurred');
    }
  }

  Future<dynamic> updateUser() async {
    try {
      // get token and user_id
      final _storage = new FlutterSecureStorage();
      String _token = await _storage.read(key: 'jwt');

      final _url = Uri.parse('http://10.0.2.2:3000/api/users/user');

      Map<String, dynamic> body = {
        'user': {'name': this.name, 'email': this.email}
      };

      final response = await http.put(_url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': _token
          },
          body: jsonEncode(body));

      if (response.statusCode == 200) {
        // fetch new user data
        var rBody = jsonDecode(response.body);
        this.name = rBody['data']['attributes']['name'];
        this.email = rBody['data']['attributes']['email'];

        final data = {'name': this.name, 'email': this.email};

        return User.fromJson(data);
      }
    } catch (e) {
      throw Exception('Some error ocurred');
    }
  }
}
