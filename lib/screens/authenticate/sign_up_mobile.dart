import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:oops/screens/home/bottom_nav_bar.dart';
import 'package:oops/screens/shared/wave_loading.dart';
import 'package:oops/services/sign_up.dart';

class SignUpMobile extends StatefulWidget {
  final Function toggleView;

  SignUpMobile({this.toggleView});

  @override
  _SignUpMobileState createState() => _SignUpMobileState();
}

class _SignUpMobileState extends State<SignUpMobile> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _password = '';
  String _passwordConfirmation = '';

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
                              padding: EdgeInsets.only(left: 40, right: 40),
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
                                      fillColor: Colors.grey[200],
                                      focusColor: Colors.grey[300],
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
                                    onChanged: (value) {
                                      setState(() => _name = value);
                                    },
                                    // Validate if name is not empty and if it doesn't contain numbers nor symbols
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Indique seu nome.';
                                      }
                                      if ((new RegExp(
                                              r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]',
                                              multiLine: false)
                                          .hasMatch(value))) {
                                        return 'Nomes não devem conter números ou símbolos';
                                      }
                                      return null;
                                    },
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
                                    // Validate if password is not empty and is strong
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Indique a sua senha';
                                      } else if (value.length < 6) {
                                        return 'Senha deve conter 6 caracteres ou mais';
                                      } else if (!(new RegExp(
                                              r'^(?=.*[A-Z].*)(?=.*[0-9].*)(?=.*[a-z].*).{6,64}$',
                                              multiLine: true)
                                          .hasMatch(value))) {
                                        return 'Senha deve conter letras minúsculas,\nmaiúsculas e números';
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
                                              _obscurePassword =
                                                  !_obscurePassword;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(
                                          () => _passwordConfirmation = value);
                                    },
                                    // Validate if passwords match
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Repita a senha';
                                      } else if (value != _password) {
                                        return 'Senhas não combinam';
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
                                          await SignUp(
                                                  name: _name,
                                                  email: _email.replaceAll(
                                                      new RegExp(r'\s+'), ''),
                                                  password:
                                                      _passwordConfirmation
                                                          .replaceAll(
                                                              new RegExp(
                                                                  r'\s+'),
                                                              ''))
                                              .signUp();

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
                                            style:
                                                TextStyle(color: Colors.black)),
                                        TextSpan(
                                          text: 'Entrar',
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
      width: MediaQuery.of(context).size.width,
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
