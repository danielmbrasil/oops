import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:oops/screens/activities/multiple_choice_quiz.dart';
import 'package:oops/screens/activities/true_false_quiz.dart';

class Quiz extends StatefulWidget {
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

  Quiz(
      {@required this.data,
      @required this.index,
      @required this.max,
      @required this.userAnswers,
      @required this.currentLevel});

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        leading: widget.userAnswers.containsKey('0')
            ? Container()
            : IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 28,
                ),
              ),
        centerTitle: true,
        title: Text(
          'Quiz',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
      // question_type == 1 stands for questions with "true" or "false" choices
      // question_type == 2 stands for questions with multiple choices
      body: widget.data[widget.index]['question_type'] == 1
          ? TrueFalseQuiz(
              data: widget.data,
              index: widget.index,
              max: widget.data.length - 1,
              userAnswers: widget.userAnswers,
              currentLevel: widget.currentLevel,
            )
          : MultipleChoiceQuiz(
              data: widget.data,
              index: widget.index,
              max: widget.data.length - 1,
              userAnswers: widget.userAnswers,
              currentLevel: widget.currentLevel,
            ),
    );
  }
}
