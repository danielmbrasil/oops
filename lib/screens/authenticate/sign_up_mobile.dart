import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpMobile extends StatefulWidget {
  final Function toggleView;

  SignUpMobile({this.toggleView});

  @override
  _SignUpMobileState createState() => _SignUpMobileState();
}

class _SignUpMobileState extends State<SignUpMobile> {
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1.4,
          color: Colors.white,
          child: Stack(
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(top: 50, bottom: 30),
                            child: Text(
                              'Inserir dados',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontFamily: 'Mulish',
                                fontStyle: FontStyle.normal,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontFamily: 'Mulish',
                                fontStyle: FontStyle.normal,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 20),
                                fillColor: const Color(0xFFE0E0E0),
                                focusColor: const Color(0xFFBFBFBD),
                                filled: true,
                                hintStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: 'Mulish',
                                  fontStyle: FontStyle.normal,
                                ),
                                hintText: 'Digite seu nome',
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.person,
                                      color: Colors.black,
                                      size: 26,
                                    ),
                                    onPressed: () => null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontFamily: 'Mulish',
                                fontStyle: FontStyle.normal,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 20),
                                fillColor: const Color(0xFFE0E0E0),
                                focusColor: const Color(0xFFBFBFBD),
                                filled: true,
                                hintStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: 'Mulish',
                                  fontStyle: FontStyle.normal,
                                ),
                                hintText: 'Digite seu e-mail',
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.email_outlined,
                                      color: Colors.black,
                                      size: 26,
                                    ),
                                    onPressed: () => null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: TextFormField(
                              obscureText: _obscurePassword,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontFamily: 'Mulish',
                                fontStyle: FontStyle.normal,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 20),
                                fillColor: const Color(0xFFE0E0E0),
                                focusColor: const Color(0xFFBFBFBD),
                                filled: true,
                                hintStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: 'Mulish',
                                  fontStyle: FontStyle.normal,
                                ),
                                hintText: 'Crie uma senha',
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.lock_rounded
                                          : Icons.lock_open_rounded,
                                      color: Colors.black,
                                      size: 26,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: TextFormField(
                              obscureText: _obscurePassword,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontFamily: 'Mulish',
                                fontStyle: FontStyle.normal,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 20),
                                fillColor: const Color(0xFFE0E0E0),
                                focusColor: const Color(0xFFBFBFBD),
                                filled: true,
                                hintStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: 'Mulish',
                                  fontStyle: FontStyle.normal,
                                ),
                                hintText: 'Confirmar senha',
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.lock_rounded
                                          : Icons.lock_open_rounded,
                                      color: Colors.black,
                                      size: 26,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 80,
                            padding:
                            EdgeInsets.only(left: 40, right: 40, top: 20),
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.blueAccent[700]),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                              ),
                              onPressed: () => null,
                              child: Text(
                                'Criar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Mulish',
                                  fontStyle: FontStyle.normal,
                                  fontSize: 22,
                                ),
                                textAlign: TextAlign.center,
                                //overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontFamily: 'Mulish',
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Já possui uma conta? ',
                                      style: TextStyle(color: Colors.black)),
                                  TextSpan(
                                    text: 'Entrar',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => widget.toggleView(),
                                    style: TextStyle(
                                      color: Colors.blueAccent[700],
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
