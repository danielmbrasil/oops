import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:oops/screens/shared/wave_loading.dart';
import 'package:oops/services/users.dart';

class RateActivity extends StatefulWidget {
  final int currentLevel;

  RateActivity({@required this.currentLevel});

  @override
  _RateActivityState createState() => _RateActivityState();
}

class _RateActivityState extends State<RateActivity> {
  double _userRating = 0.0;

  bool _loading = true;
  bool _rated = false;
  bool _thank = false;

  void _fetchUserGrade() async {
    try {
      var grade = await UsersService().getUserFeedback(widget.currentLevel);
      setState(() {
        _userRating = grade.toDouble();
        _loading = false;
        _rated = true;
      });
    } catch (e) {
      print(e.toString());
      setState(() => _loading = false);
    }
  }

  void _saveUserGrade() async {
    try {
      setState(() {
        _loading = true;
        _rated = true;
        _thank = true;
      });

      await UsersService()
          .postUserFeedback(widget.currentLevel, _userRating.toInt());

      setState(() => _loading = false);
    } catch (e) {
      print(e.toString());
      setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserGrade();
  }

  @override
  Widget build(BuildContext context) {
    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenHeight = MediaQuery.of(context).size.height;

    return _loading
        ? WaveLoading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueAccent[700],
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              centerTitle: true,
              title: Text(
                'Avaliar Atividade',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
            ),
            body: Container(
              width: _screenWidth,
              height: _screenHeight,
              padding: EdgeInsets.all(20),
              child: Center(
                child: _thank
                    ? Stack(
                        children: [
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: _screenWidth * 0.8,
                                height: _screenHeight * 0.3,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Muito obrigado por sua avaliação!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            top: _screenHeight * 0.04,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: _screenWidth * 0.5,
                                height: _screenHeight * 0.3,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/correct_answer.png'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Stack(
                        children: [
                          Positioned.fill(
                            bottom: 100,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                _rated
                                    ? 'Sua avaliação'
                                    : 'Dê uma nota à atividade',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: RatingBar.builder(
                                initialRating: _userRating,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: _rated
                                    ? null
                                    : (rating) {
                                        setState(() => _userRating = rating);
                                      },
                              ),
                            ),
                          ),
                          _rated
                              ? Container()
                              : Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: InkWell(
                                      onTap: () async {
                                        _saveUserGrade();
                                      },
                                      borderRadius: BorderRadius.circular(50),
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: _screenWidth * 0.35,
                                        height: _screenHeight * 0.06,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.blueAccent),
                                        child: Text(
                                          'Salvar',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                        ],
                      ),
              ),
            ),
          );
  }
}
