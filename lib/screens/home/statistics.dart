import 'package:flutter/material.dart';
import 'package:oops/models/user.dart';
import 'package:oops/screens/shared/wave_loading.dart';
import 'package:oops/services/users.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  var _containerBackgroundColor = Colors.grey.shade400;

  bool _loading = true;

  String _xp = '';
  String _currentLevel = '';
  String _correctAnswers = '';

  void _getUserStatistic() async {
    try {
      User user = await UsersService().fetchUserStatistic();
      setState(() {
        _xp = user.getXp().toString();
        _currentLevel = user.getCurrentLevel().toString();
        _correctAnswers = user.getCorrectAnswers().toString();
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserStatistic();
  }

  Widget _customContainer(double screenWidth, double screenHeight, String title,
      String value, double progress) {
    return Container(
      height: screenHeight * 0.2,
      width: screenWidth * 0.7,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: _containerBackgroundColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Container(
            height: screenHeight * 0.04,
            width: screenWidth * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment(1, 0.0),
                  colors: <Color>[
                    Colors.grey.shade100,
                    Colors.grey.shade300,
                  ],
                  tileMode: TileMode.repeated,
                )),
            child: Stack(
              children: [
                Container(
                  width: (screenWidth * 0.8) * progress,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment(1, 0.0),
                      colors: <Color>[Colors.blue[500], Colors.blue[800]],
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenHeight = MediaQuery.of(context).size.height;

    return _loading
        ? WaveLoading()
        : Scaffold(
            body: ListView(
              padding: EdgeInsets.all(20),
              children: [
                SizedBox(height: 20),
                _customContainer(_screenWidth, _screenHeight, 'XP',
                    _xp + '/450', int.parse(_xp) / 450.0),
                SizedBox(height: 20),
                _customContainer(_screenWidth, _screenHeight, 'Nível',
                    _currentLevel + '/4', int.parse(_currentLevel) / 4.0),
                SizedBox(height: 20),
                _customContainer(_screenWidth, _screenHeight, 'Quiz',
                    _correctAnswers + '/33', int.parse(_correctAnswers) / 33.0),
                SizedBox(height: 50)
              ],
            ),
          );
  }
}
