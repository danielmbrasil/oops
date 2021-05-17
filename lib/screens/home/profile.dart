import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:oops/models/user.dart';
import 'package:oops/screens/authenticate/authenticate.dart';
import 'package:oops/screens/shared/wave_loading.dart';
import 'package:oops/services/sign_in.dart';
import 'package:oops/services/users.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';

  bool _loading = true;

  void _getUser() async {
    try {
      User _user = await UsersService().fetchUser();
      setState(() {
        _name = _user.getName();
        _email = _user.getEmail();
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      print(e.toString());
    }
  }

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? WaveLoading()
        : Scaffold(
            body: ListView(
              padding:
                  EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 80),
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('assets/images/willy1.png'),
                          //fit: BoxFit.fill
                        )),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Seus dados',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontFamily: 'Mulish',
                                fontStyle: FontStyle.normal,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
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
                              initialValue: _name,
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
                          SizedBox(height: 10),
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
                              initialValue: _email,
                              onChanged: (value) {
                                setState(() => _email = value);
                              },
                              // Validate if email is not empty and is in a valid format
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Indique seu endereço de email';
                                } else if (!EmailValidator.validate(_email
                                    .replaceAll(new RegExp(r"\s+"), ''))) {
                                  return 'Indique um endereço de email válido';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width * 0.6,
                            padding: EdgeInsets.only(top: 20),
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
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  try {
                                    setState(() => _loading = true);
                                    User _user = await UsersService(
                                            name: _name, email: _email)
                                        .updateUser();

                                    setState(() {
                                      _name = _user.getName();
                                      _email = _user.getEmail();
                                      _loading = false;
                                    });
                                  } catch (e) {
                                    setState(() => _loading = false);

                                    print(e.toString());
                                  }
                                }
                              },
                              child: Text(
                                'Atualizar Dados',
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
                            height: 80,
                            width: MediaQuery.of(context).size.width * 0.6,
                            padding: EdgeInsets.only(top: 20),
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
                              onPressed: () async {
                                try {
                                  setState(() => _loading = true);
                                  SignIn().signOut();

                                  await Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              Authenticate()));
                                } catch (e) {
                                  setState(() => _loading = false);

                                  print(e.toString());
                                }
                              },
                              child: Text(
                                'Sair',
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
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
  }
}
