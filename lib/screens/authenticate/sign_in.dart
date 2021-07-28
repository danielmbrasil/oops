import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:oops/screens/home/bottom_nav_bar.dart';
import 'package:oops/screens/shared/wave_loading.dart';
import 'package:oops/services/sign_in.dart' as service;

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  bool _obscurePassword = true;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return _loading
        ? WaveLoading()
        : Scaffold(
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
                                      fillColor: Colors.grey[200],
                                      focusColor: Colors.grey[300],
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
                                    onChanged: (value) {
                                      setState(() => _email = value);
                                    },
                                    // Validate if email is not empty and is in a valid format
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Indique seu endereço de email';
                                      } else if (!EmailValidator.validate(
                                          _email.replaceAll(
                                              new RegExp(r"\s+"), ''))) {
                                        return 'Indique um endereço de email válido';
                                      }
                                      return null;
                                    },
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
                                      fillColor: Colors.grey[200],
                                      focusColor: Colors.grey[300],
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
                                              _obscurePassword =
                                                  !_obscurePassword;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() => _password = value);
                                    },
                                    // Validate if password is not empty
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Indique a sua senha';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Container(
                                  height: 80,
                                  padding: EdgeInsets.only(
                                      left: 40, right: 40, top: 20),
                                  child: TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blueAccent[700]),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        setState(() => _loading = true);

                                        try {
                                          await service.SignIn(
                                                  email: _email.replaceAll(
                                                      new RegExp(r'\s+'), ''),
                                                  password:
                                                      _password.replaceAll(
                                                          new RegExp(r'\s+'),
                                                          ''))
                                              .signIn();

                                          await Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                      BottomNavBar()));
                                        } catch (e) {
                                          setState(() => _loading = false);

                                          await showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  _buildErrorDialog(
                                                      context,
                                                      e
                                                          .toString()
                                                          .substring(11)));
                                        }
                                      }
                                    },
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
                                            text: 'Não possui uma conta? ',
                                            style:
                                                TextStyle(color: Colors.black)),
                                        TextSpan(
                                          text: 'Cadastre - se',
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => widget.toggleView(),
                                          style: TextStyle(
                                            color: Colors.blueAccent[700],
                                            decoration:
                                                TextDecoration.underline,
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

// Build error dialog with error detail
Widget _buildErrorDialog(BuildContext context, String errorDetail) {
  return AlertDialog(
    title: Text(
      'Erro',
      style: TextStyle(
        fontFamily: 'Mulish',
        fontStyle: FontStyle.normal,
        fontSize: 22,
      ),
    ),
    content: Container(
      constraints: BoxConstraints(maxWidth: 400, minWidth: 200),
      width: double.infinity,
      height: 100,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Positioned.fill(
            bottom: 50,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                errorDetail,
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Fechar',
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
