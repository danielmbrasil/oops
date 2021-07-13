import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oops/screens/authenticate/authenticate.dart';
import 'package:http/http.dart' as http;
import 'package:oops/screens/home/bottom_nav_bar.dart';
import 'package:oops/screens/shared/wave_loading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oops!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CheckToken(),
      routes: <String, WidgetBuilder> {
        '/home': (BuildContext context) => BottomNavBar()
      },
    );
  }
}

class CheckToken extends StatefulWidget {
  @override
  _CheckTokenState createState() => _CheckTokenState();
}

class _CheckTokenState extends State<CheckToken> {
  bool _isValid = false;
  bool _loading = true;

  @override
  void initState() {
    _isTokenValid();
    super.initState();
  }

  void _isTokenValid() async {
    try {
      // get token and user_id
      final storage = new FlutterSecureStorage();
      String token = await storage.read(key: 'jwt');

      final url = Uri.parse('http://10.0.2.2:3000/api/users/user');

      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token
      });

      if (response.statusCode == 200) {
        setState(() {
          _isValid = true;
          _loading = false;
        });
      } else {
        setState(() => _loading = false);
      }
    } catch (_) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? WaveLoading()
        : (_isValid ? BottomNavBar() : Authenticate());
  }
}
