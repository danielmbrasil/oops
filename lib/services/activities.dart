import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:oops/models/activity.dart';

class ActivitiesService {
  final int currentLevel;
  final String _baseURL = '10.0.2.2:3000';

  ActivitiesService({@required this.currentLevel});

  /// Fetch activity data with current_level param
  ///
  /// @return Activity
  Future<dynamic> fetchActivity() async {
    try {
      // get token and user_id
      final _storage = new FlutterSecureStorage();
      String _token = await _storage.read(key: 'jwt');

      Map<String, dynamic> params = {
        'level_number': this.currentLevel.toString()
      };

      final _url = Uri.http(_baseURL, '/api/activity', params);

      final response = await http.get(_url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': _token
      });

      if (response.statusCode == 200) {
        var rBody = jsonDecode(response.body);

        final data = {
          'title': rBody['data']['title'],
          'body': rBody['data']['body'],
          'xp': rBody['data']['xp']
        };

        return Activity.fromJson(data);
      } else {
        throw Exception('Some error ocurred');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Some error ocurred');
    }
  }
}
