import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oops/models/user.dart';
import 'package:http/http.dart' as http;

class UsersService {
  String _name = '';
  String _email = '';

  Future<dynamic> fetchUser() async {
    try {
      // get token and user_id
      final _storage = new FlutterSecureStorage();
      String _token = await _storage.read(key: 'jwt');
      String _id = await _storage.read(key: 'user_id');

      final _url = Uri.parse('http://10.0.2.2:3000/api/users/' + _id);

      final response = await http.get(_url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': _token
      });

      if (response.statusCode == 200) {
        var rBody = jsonDecode(response.body);
        this._name = rBody['data']['attributes']['name'];
        this._email = rBody['data']['attributes']['email'];

        final userData = {'id': int.parse(_id), 'name': this._name, 'email': this._email, 'token': _token};

        return User.fromJson(userData);
      } else {
        throw Exception('Some error ocurred');
      }
    } catch(e) {
      throw Exception('Some error ocurred');
    }
  }
}