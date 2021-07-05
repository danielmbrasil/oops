import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oops/models/user.dart';
import 'package:http/http.dart' as http;

class UsersService {
  String name = '';
  String email = '';
  final String _baseURL = 'http://10.0.2.2:3000';

  UsersService({this.name, this.email});

  /// Fetch current user data
  ///
  /// @return User
  Future<dynamic> fetchUser() async {
    try {
      // get token and user_id
      final _storage = new FlutterSecureStorage();
      String _token = await _storage.read(key: 'jwt');

      final _url = Uri.parse(_baseURL + '/api/users/user');

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

  /// Update a single user data
  ///
  /// @return User
  Future<dynamic> updateUser() async {
    try {
      // get token and user_id
      final _storage = new FlutterSecureStorage();
      String _token = await _storage.read(key: 'jwt');

      final _url = Uri.parse(_baseURL + '/api/users/user');

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

  /// Fetch all users ordered by XP
  ///
  /// @return a List of Maps which contains users data
  Future<dynamic> fetchUsers() async {
    try {
      // get token and user_id
      final _storage = new FlutterSecureStorage();
      String _token = await _storage.read(key: 'jwt');

      final _url = Uri.parse(_baseURL + '/api/users');

      final response = await http.get(
        _url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': _token
        },
      );

      if (response.statusCode == 200) {
        // fetch all users data, ordered by total xp
        var rBody = jsonDecode(response.body);

        return rBody['data'];
      }
    } catch (e) {
      throw Exception('Some error ocurred');
    }
  }

  /// Fetch all current user statistics
  ///
  /// @return User
  Future<dynamic> fetchUserStatistic() async {
    try {
      // get token and user_id
      final _storage = new FlutterSecureStorage();
      String _token = await _storage.read(key: 'jwt');

      final _url = Uri.parse(_baseURL + '/api/users/statistic');

      final response = await http.get(
        _url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': _token
        },
      );

      if (response.statusCode == 200) {
        // fetch all users data, ordered by total xp
        var rBody = jsonDecode(response.body);

        final data = {
          'xp': rBody['data']['xp'],
          'current_level': rBody['data']['current_level'],
          'correct_answers': rBody['data']['correct_answers']
        };

        return User.fromJson(data);
      }
    } catch (e) {
      throw Exception('Some error ocurred');
    }
  }
}
