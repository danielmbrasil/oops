import 'package:flutter/material.dart';

class Activity extends StatefulWidget {
  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  final _textStyle = TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    var _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
          'Nível x',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: TextButton(
              onPressed: () {},
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
              onPressed: () {},
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
