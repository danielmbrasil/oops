import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:oops/screens/authenticate/sign_up_mobile.dart';
import 'package:oops/screens/authenticate/sign_up_web.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;

  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return SignUpWeb(toggleView: widget.toggleView);
    } else {
      return SignUpMobile();
    }
  }
}


