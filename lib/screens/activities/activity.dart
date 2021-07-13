import 'package:flutter/material.dart';
import 'package:oops/screens/activities/introduction.dart';
import 'package:oops/screens/activities/quiz.dart';
import 'package:oops/screens/shared/wave_loading.dart';
import 'package:oops/services/quizzes.dart';

class Activity extends StatefulWidget {
  // Level which activity belongs to
  final int currentLevel;

  Activity({@required this.currentLevel});

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  final _textStyle = TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  bool _loading = true;

  bool _answered = false;

  List<Map<String, dynamic>> _questions = [];

  // Default user's progress map
  // acquired_xp and correct_answers are the only information that is going to
  // be sent to the API
  Map<String, dynamic> _userAnswers = {'acquired_xp': 0, 'correct_answers': 0};

  // Get quiz (list of questions) for the current_level
  void _getQuiz() async {
    try {
      var questions =
          await QuizzesService(currentLevel: widget.currentLevel).fetchQuiz();
      bool answered = await QuizzesService(currentLevel: widget.currentLevel)
          .fetchUserAnswer();
      setState(() {
        _questions = List.from(questions);
        _loading = false;
        _answered = answered;
      });
    } catch (e) {
      print(e.toString());
      setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _getQuiz();
  }

  @override
  Widget build(BuildContext context) {
    var _screenWidth = MediaQuery.of(context).size.width;

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
                'Nível ' + widget.currentLevel.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
            ),
            body: ListView(
              padding: EdgeInsets.all(20),
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Introduction(
                                  currentLevel: widget.currentLevel)));
                    },
                    child: Text(
                      'Introdução',
                      style: _textStyle,
                    ),
                  ),
                ),
                Container(
                  width: _screenWidth,
                  height: 1,
                  color: Colors.black,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: _answered
                        ? () async {
                            await showDialog(
                                context: context,
                                builder: (context) =>
                                    _buildAlertDialog(context));
                          }
                        : () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Quiz(
                                  data: _questions,
                                  index: 0,
                                  max: _questions.length,
                                  userAnswers: _userAnswers,
                                  currentLevel: widget.currentLevel,
                                ),
                              ),
                            );
                          },
                    child: Text(
                      'Quiz',
                      style: _textStyle,
                    ),
                  ),
                ),
                Container(
                  width: _screenWidth,
                  height: 1,
                  color: Colors.black,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 6),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Avaliar atividade',
                      style: _textStyle,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

Widget _buildAlertDialog(BuildContext context) {
  return AlertDialog(
    title: Text(
      'Aviso',
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
                'Quiz já foi realizado',
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
