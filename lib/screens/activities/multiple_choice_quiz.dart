import 'package:flutter/material.dart';
import 'package:oops/screens/activities/quiz.dart';
import 'package:oops/screens/activities/result.dart';

class MultipleChoiceQuiz extends StatefulWidget {
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

  MultipleChoiceQuiz(
      {@required this.data,
      @required this.index,
      @required this.max,
      @required this.userAnswers,
      @required this.currentLevel});

  @override
  _MultipleChoiceQuizState createState() => _MultipleChoiceQuizState();
}

class _MultipleChoiceQuizState extends State<MultipleChoiceQuiz> {
  // _option represents what alternative user has chosen
  // 0 is default value and does not represent any alternative
  // 1: first option, letter "A"
  // 2: second option, letter "B"
  // 3: third option, letter "C"
  // 4: fourth option, letter "D"
  int _option = 0;

  // represents user choice. It can be "A", "B", "C" or "D"
  String _userAnswer;

  // verifies if user clicked on "check"
  // when user checks answers, it locks the question so user can no loger change
  // their choice
  bool _userAnswered = false;

  // default textstyle for "check answer" response
  final _checkAnswerTextStyle =
      TextStyle(fontSize: 22, fontWeight: FontWeight.bold);

  // set user option for when there's an option
  // i.e. user has already answered this question and went back or forth,
  // so when they come back to this question screen, their choice is still highlighted
  void _setOption(String userChoice) {
    switch (userChoice) {
      case 'A':
        _option = 1;
        break;
      case 'B':
        _option = 2;
        break;
      case 'C':
        _option = 3;
        break;
      case 'D':
        _option = 4;
        break;
    }
  }

  // builds row with every choice of the given question
  Widget _buildAlternativesRow(
      String alternative, double screenWidth, int option) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: _userAnswered
                ? null
                : () {
                    // switch to translate indexes to letters and set _option value
                    switch (option) {
                      case 1:
                        setState(() {
                          _userAnswer = 'A';
                          _option = 1;
                          _userAnswers[widget.index.toString()]['user_choice'] =
                              'A';
                        });
                        break;
                      case 2:
                        setState(() {
                          _userAnswer = 'B';
                          _option = 2;
                          _userAnswers[widget.index.toString()]['user_choice'] =
                              'B';
                        });
                        break;
                      case 3:
                        setState(() {
                          _userAnswer = 'C';
                          _option = 3;
                          _userAnswers[widget.index.toString()]['user_choice'] =
                              'C';
                        });
                        break;
                      case 4:
                        setState(() {
                          _userAnswer = 'D';
                          _option = 4;
                          _userAnswers[widget.index.toString()]['user_choice'] =
                              'D';
                        });
                    }
                  },
            child: Container(
              width: screenWidth * 0.05,
              height: screenWidth * 0.05,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey.shade500),
              child: _option == option
                  ? Stack(
                      children: [
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: screenWidth * 0.02,
                              height: screenWidth * 0.02,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.lightBlueAccent[700]),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ),
          ),
          SizedBox(width: 10),
          Flexible(
            child: Text(
              alternative,
              style: TextStyle(
                  fontSize: screenWidth * 0.05, fontWeight: FontWeight.w500),
              textAlign: TextAlign.left,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

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
        _userAnswer = _userAnswers[widget.index.toString()]['user_choice'];
        _userAnswered = _userAnswers[widget.index.toString()]['answered'];
        _setOption(_userAnswer);
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
                  _buildAlternativesRow(
                      widget.data[widget.index]['option_a'], _screenWidth, 1),
                  _buildAlternativesRow(
                      widget.data[widget.index]['option_b'], _screenWidth, 2),
                  _buildAlternativesRow(
                      widget.data[widget.index]['option_c'], _screenWidth, 3),
                  _buildAlternativesRow(
                      widget.data[widget.index]['option_d'], _screenWidth, 4),
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
                        if (_userAnswer ==
                            widget.data[widget.index]['correct_answer']) {
                          _saveUserAnswers(widget.data[widget.index]['xp']);
                          // update flag to 0 so that xp and correct_answers will
                          // no long be changed
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
                        if (_userAnswer ==
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
                            if (_userAnswer ==
                                widget.data[widget.index]['correct_answer']) {
                              _saveUserAnswers(widget.data[widget.index]['xp']);
                            }
                            // user checked answer, their choice can no longer be changed
                            // question is "locked"
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
                : _userAnswer == widget.data[widget.index]['correct_answer']
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
