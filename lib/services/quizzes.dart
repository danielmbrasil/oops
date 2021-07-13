import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class QuizzesService {
  final int currentLevel;
  final String _baseURL = '10.0.2.2:3000';

  QuizzesService({@required this.currentLevel});

  /// Fetch quiz data with current_level param
  ///
  /// @return List of maps with quiz questions
  Future<dynamic> fetchQuiz() async {
    try {
      // get token and user_id
      final _storage = new FlutterSecureStorage();
      String _token = await _storage.read(key: 'jwt');

      Map<String, dynamic> params = {
        'level_number': this.currentLevel.toString()
      };

      final _url = Uri.http(_baseURL, '/api/quiz', params);

      final response = await http.get(_url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': _token
      });

      if (response.statusCode == 200) {
        var rBody = jsonDecode(response.body);

        return rBody['data'];
      } else {
        throw Exception('Some error ocurred');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Some error ocurred');
    }
  }

  // Create 'answer' record to mark what quizzes were done by user
  Future<dynamic> postUserProgress() async {
    try {
      // get token and user_id
      final _storage = new FlutterSecureStorage();
      String _token = await _storage.read(key: 'jwt');

      Map<String, dynamic> params = {
        'level_number': this.currentLevel.toString()
      };

      final _url = Uri.http(_baseURL, '/api/users/answer', params);

      final response = await http.post(_url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': _token
      });

      if (response.statusCode == 201) {
        var rBody = jsonDecode(response.body);

        return rBody['data'];
      } else {
        throw Exception('Some error ocurred');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Some error ocurred');
    }
  }

  // If answer if ound (status 200) then user has already done the quiz
  Future<dynamic> fetchUserAnswer() async {
    try {
      // get token and user_id
      final _storage = new FlutterSecureStorage();
      String _token = await _storage.read(key: 'jwt');

      Map<String, dynamic> params = {
        'level_number': this.currentLevel.toString()
      };

      final _url = Uri.http(_baseURL, '/api/users/answer', params);

      final response = await http.get(_url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': _token
      });

      return Future.value(response.statusCode == 200);
    } catch (e) {
      print(e.toString());
      throw Exception('Some error ocurred');
    }
  }

  // Update user's statistic with xp and correct_answers number
  Future<dynamic> updateUserStatistic(Map<String, dynamic> data) async {
    try {
      // get token and user_id
      final _storage = new FlutterSecureStorage();
      String _token = await _storage.read(key: 'jwt');

      Map<String, dynamic> params = {
        'xp': data['acquired_xp'].toString(),
        'correct_answers': data['correct_answers'].toString()
      };

      final url = Uri.http(_baseURL, '/api/users/statistic', params);

      final response = await http.put(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': _token
      });

      if (response.statusCode == 200) {
        var rBody = jsonDecode(response.body);

        return rBody['data'];
      } else {
        throw Exception('Some error ocurred');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Some error ocurred');
    }
  }
}
