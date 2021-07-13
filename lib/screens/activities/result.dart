import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:oops/models/activity.dart' as model;
import 'package:oops/screens/shared/wave_loading.dart';
import 'package:oops/services/activities.dart';
import 'package:oops/services/quizzes.dart';

class Result extends StatefulWidget {
  final Map<String, dynamic> result;

  final int currentLevel;

  Result({@required this.result, @required this.currentLevel});

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  // total xp a user can get from a quiz
  int _xp = 0;

  // var to show loading screen while waiting for API response
  bool _loading = true;

  // fetch activity data to get activity's max XP
  void _getActivity() async {
    try {
      model.Activity actvity =
          await ActivitiesService(currentLevel: widget.currentLevel)
              .fetchActivity();
      setState(() {
        _xp = actvity.getXP();
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _getActivity();
  }

  @override
  Widget build(BuildContext context) {
    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenHeight = MediaQuery.of(context).size.height;

    return _loading
        ? WaveLoading()
        : Scaffold(
            body: Container(
              width: _screenWidth,
              height: _screenHeight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Quiz finalizado',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Respostas corretas: ' +
                                  widget.result['correct_answers'].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'XP obtido: ' +
                                  widget.result['acquired_xp'].toString() +
                                  '/' +
                                  _xp.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: InkWell(
                              onTap: () async {
                                setState(() => _loading = true);
                                try {
                                  await QuizzesService(
                                          currentLevel: widget.currentLevel)
                                      .postUserProgress();

                                  await QuizzesService(
                                          currentLevel: widget.currentLevel)
                                      .updateUserStatistic(widget.result);

                                  await Navigator.pushReplacementNamed(
                                      context, '/home');
                                } catch (e) {
                                  setState(() => _loading = false);
                                  print(e.toString());
                                }
                              },
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                alignment: Alignment.center,
                                width: _screenWidth * 0.35,
                                height: _screenHeight * 0.06,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.blueAccent),
                                child: Text(
                                  'Concluir',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    bottom: -80,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: _screenWidth * 0.6,
                        height: _screenHeight * 0.4,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/willy-home.png'))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
