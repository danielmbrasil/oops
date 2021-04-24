import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1.3,
          color: Colors.white,
          child: Stack(
            children: [
              Positioned.fill(
                top: 250,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 500,
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                          bottom: Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius: 0.5, // changes position of shadow
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        padding: EdgeInsets.only(left: 60, right: 60),
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
                                hintText: 'Email',
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
                                hintText: 'Senha',
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
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              'Esqueceu a sua senha?',
                              style: TextStyle(
                                color: Colors.blue,
                                fontFamily: 'Mulish',
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
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
                                'Entrar',
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
                                      text: 'Não possui uma conta?',
                                      style: TextStyle(color: Colors.black)),
                                  TextSpan(
                                    text: ' Cadastre - se',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => null,
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
              Positioned.fill(
                top: 20,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 280,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/willy0.png'),
                          fit: BoxFit.fitHeight),
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
