import 'package:flutter/material.dart';
import 'package:oops/screens/sessions/sign_in.dart';

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
      home: SignIn(),
    );
  }
}

