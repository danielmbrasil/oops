import 'package:flutter/material.dart';
import 'package:oops/screens/activities/quiz.dart';
import 'package:oops/screens/activities/result.dart';

class TrueFalseQuiz extends StatefulWidget {
  // List of questions
  final List<dynamic> data;

  // Current index of the list (i.e. current question of the quiz)
  final int index;

  // Max index (i.e. list.lenght -1)
  final int max;

  // Map that contains user's progress throughtout the quiz
  final Map<String, dynamic> userAnswers;

  // Current level, level to which quiz belongs to
  final int currentLevel;

  TrueFalseQuiz(
      {@required this.data,
      @required this.index,
      @required this.max,
      @required this.userAnswers,
      @required this.currentLevel});

  @override
  _TrueFalseQuizState createState() => _TrueFalseQuizState();
}

class _TrueFalseQuizState extends State<TrueFalseQuiz> {
  // user selected one of the 2 choices
  // this is used to change color of button so that it looks selected
  bool _selected = false;

  // represents user choice which can be "A" for true or "B" for false
  String _userChoice;

  // verifies if user clicked on "check"
  // when user checks answers, it locks the question so user can no loger change
  // their choice
  bool _userAnswered = false;

  // default textstyle for "check answer" response
  final _checkAnswerTextStyle =
      TextStyle(fontSize: 22, fontWeight: FontWeight.bold);

  // Map with user's progress during a question
  Map<String, dynamic> _userAnswers = new Map();

  // User's answers was correct? add xp and increment number of correct answers
  // xp = -1 flag checks if user has already visited the screen, if yes, the xp
  // and correct_answers must not be incremented
  void _saveUserAnswers(int xp) {
    if (xp > 0 && _userAnswers[widget.index.toString()]['xp'] == -1) {
      _userAnswers['acquired_xp'] += xp;
      _userAnswers['correct_answers']++;
    }
  }

  // Gets data passed through class constructor
  @override
  void initState() {
    super.initState();
    setState(() {
      _userAnswers = widget.userAnswers;
      if (_userAnswers.containsKey(widget.index.toString())) {
        _selected = true;
        _userChoice = _userAnswers[widget.index.toString()]['user_choice'];
        _userAnswered = _userAnswers[widget.index.toString()]['answered'];
      } else {
        _userAnswers[widget.index.toString()] = {
          'answered': false,
          'user_choice': 'F',
          'xp': -1
        };
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: _screenWidth,
      height: _screenHeight,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      widget.data[widget.index]['question_number'].toString() +
                          '. ' +
                          widget.data[widget.index]['title'],
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        // if user answered, button is disabled
                        onTap: _userAnswered
                            ? null
                            : () {
                                setState(() {
                                  _userChoice = 'A';
                                  _userAnswers[widget.index.toString()]
                                      ['user_choice'] = 'A';
                                  _selected = true;
                                });
                              },
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          alignment: Alignment.center,
                          width: _screenWidth * 0.3,
                          height: _screenWidth * 0.15,
                          decoration: BoxDecoration(
                            color: _selected && _userChoice == 'A'
                                ? Colors.green[700]
                                : Colors.green,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            widget.data[widget.index]['option_a'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      InkWell(
                        // if user answered, button is disabled
                        onTap: _userAnswered
                            ? null
                            : () {
                                setState(() {
                                  _userChoice = 'B';
                                  _userAnswers[widget.index.toString()]
                                      ['user_choice'] = 'B';
                                  _selected = true;
                                });
                              },
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          alignment: Alignment.center,
                          width: _screenWidth * 0.3,
                          height: _screenWidth * 0.15,
                          decoration: BoxDecoration(
                            color: _userChoice == 'B' && _selected
                                ? Colors.red[700]
                                : Colors.red,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            widget.data[widget.index]['option_b'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          widget.index > 0
              ? Positioned.fill(
                  left: -10,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        // if user's answer is right, xp and correct_answers should
                        // be incremented
                        if (_userChoice ==
                            widget.data[widget.index]['correct_answer']) {
                          _saveUserAnswers(widget.data[widget.index]['xp']);
                          setState(() =>
                              _userAnswers[widget.index.toString()]['xp'] = 0);
                        }
                        Navigator.pop(context, _userAnswers);
                      },
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: _screenWidth * 0.15,
                        height: _screenWidth * 0.15,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment(1, 0.0),
                            colors: <Color>[
                              Colors.grey.shade100,
                              Colors.grey.shade300,
                            ],
                            tileMode: TileMode.repeated,
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.grey.shade900,
                          size: _screenWidth * 0.08,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          widget.index < widget.max
              ? Positioned.fill(
                  right: -10,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () async {
                        // if user's answer is right, xp and correct_answers should
                        // be incremented
                        if (_userChoice ==
                            widget.data[widget.index]['correct_answer']) {
                          _saveUserAnswers(widget.data[widget.index]['xp']);
                          setState(() =>
                              _userAnswers[widget.index.toString()]['xp'] = 0);
                        }
                        _userAnswers = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Quiz(
                              data: widget.data,
                              index: widget.index + 1,
                              max: widget.max,
                              userAnswers: _userAnswers,
                              currentLevel: widget.currentLevel,
                            ),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: _screenWidth * 0.15,
                        height: _screenWidth * 0.15,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment(1, 0.0),
                            colors: <Color>[
                              Colors.grey.shade100,
                              Colors.grey.shade300,
                            ],
                            tileMode: TileMode.repeated,
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.grey.shade900,
                          size: _screenWidth * 0.08,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          Positioned.fill(
            right: 20,
            child: Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: _userAnswered && widget.index == widget.max
                    ? () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Result(
                                      result: _userAnswers,
                                      currentLevel: widget.currentLevel,
                                    )));
                      }
                    : _userAnswered && (widget.index < widget.max)
                        ? () async {
                            _userAnswers = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Quiz(
                                  data: widget.data,
                                  index: widget.index + 1,
                                  max: widget.max,
                                  userAnswers: _userAnswers,
                                  currentLevel: widget.currentLevel,
                                ),
                              ),
                            );
                          }
                        : () {
                            // if user's answer is right, xp and correct_answers should
                            // be incremented
                            if (_userChoice ==
                                widget.data[widget.index]['correct_answer']) {
                              _saveUserAnswers(widget.data[widget.index]['xp']);
                            }
                            setState(() {
                              _userAnswered = true;
                              _userAnswers[widget.index.toString()]
                                  ['answered'] = true;
                              _userAnswers[widget.index.toString()]['xp'] = 0;
                            });
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
                    _userAnswered ? 'Continuar' : 'Verificar',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            bottom: 60,
            child: !_userAnswered
                ? Container()
                : _userChoice == widget.data[widget.index]['correct_answer']
                    ? Stack(
                        children: [
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: _screenWidth * 0.8,
                                height: _screenHeight * 0.3,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Parabéns!\nResposta correta.',
                                  textAlign: TextAlign.center,
                                  style: _checkAnswerTextStyle,
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
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
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: _screenWidth * 0.8,
                                height: _screenHeight * 0.3,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Oops!\nResposta incorreta.',
                                  textAlign: TextAlign.center,
                                  style: _checkAnswerTextStyle,
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: _screenWidth * 0.5,
                                height: _screenHeight * 0.3,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/wrong_answer.png'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}
