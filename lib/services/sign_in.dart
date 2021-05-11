import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oops/models/user.dart';
import 'package:http/http.dart' as http;

class SignIn {
  final String email;
  final String password;
  String name;

  final url = Uri.parse('http://10.0.2.2:3000/api/login');

  SignIn({this.email, this.password});

  Future<dynamic> signIn() async {
    Map<String, dynamic> body = {
      'user' : {
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
      // get user token and user name
      Map<String, dynamic> header = response.headers;
      String token = header['Authorization'];
      var rBody = jsonDecode(response.body);
      this.name = rBody['data']['attributes']['name'];

      // save token
      final storage = new FlutterSecureStorage();
      await storage.write(key: 'jwt', value: token);

      final data = {'name': this.name, 'email': this.email, 'token': token};

      return User.fromJson(data);
    } else if (response.statusCode == 401) {
      // get error message and throw excepction
      Map<String, dynamic> data = jsonDecode(response.body);

      throw Exception(data['error']);
    }
  }
}