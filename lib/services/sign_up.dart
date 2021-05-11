import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oops/models/user.dart';
import 'package:http/http.dart' as http;

class SignUp {
  final String name;
  final String email;
  final String password;

  final url = Uri.parse('http://10.0.2.2:3000/api/signup');

  SignUp({this.name, this.email, this.password});

  Future<dynamic> signUp() async {
    Map<String, dynamic> body = {
      'user': {
        'name': this.name,
        'email': this.email,
        'password': this.password
      }
    };

    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      // get user token
      Map<String, dynamic> header = response.headers;
      String token = header['Authorization'];

      // save token
      final storage = new FlutterSecureStorage();
      await storage.write(key: 'jwt', value: token);

      final data = {'name': this.name, 'email': this.email, 'token': token};

      return User.fromJson(data);
    } else if (response.statusCode == 400) {
      // get error message and throw excepction
      Map<String, dynamic> data = jsonDecode(response.body);

      throw Exception(data['errors'][0]['detail']);
    }
  }
}
