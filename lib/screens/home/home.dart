import 'package:flutter/material.dart';
import 'package:oops/screens/activities/activity.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget _activityButton(int activityNumber, double screenWidth) {
    return InkWell(
      onTap: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Activity(currentLevel: activityNumber)));
      },
      child: Container(
        width: screenWidth * 0.3,
        height: screenWidth * 0.3,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue[500],
          shape: BoxShape.circle,
        ),
        child: Text(
          activityNumber.toString(),
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height;
    var _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20),
        children: [
          SizedBox(height: 20),
          _activityButton(1, _screenWidth),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _activityButton(2, _screenWidth),
              _activityButton(3, _screenWidth),
            ],
          ),
          SizedBox(height: 20),
          _activityButton(4, _screenWidth),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.bottomCenter,
            width: _screenWidth * 0.5,
            height: _screenHeight * 0.35,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/willy-home.png'))),
          ),
        ],
      ),
    );
  }
}
