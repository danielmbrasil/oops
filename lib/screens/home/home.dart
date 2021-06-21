import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget _activityButton(
      int activityNumber, double screenWidth, double progress) {
    Map<String, double> dataMap = {
      "completed": progress,
      "not completed": 1 - progress
    };

    return MaterialButton(
      onPressed: () {},
      shape: CircleBorder(),
      child: PieChart(
        dataMap: dataMap,
        chartRadius: screenWidth * 0.3,
        colorList: <Color>[Colors.blue[800], Colors.blue[500]],
        initialAngleInDegree: 180,
        chartType: ChartType.disc,
        legendOptions: LegendOptions(
          showLegends: false,
        ),
        chartValuesOptions: ChartValuesOptions(
          showChartValues: false,
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
          _activityButton(1, _screenWidth, 0.6),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _activityButton(2, _screenWidth, 0.2),
              _activityButton(3, _screenWidth, 0),
            ],
          ),
          SizedBox(height: 20),
          _activityButton(4, _screenWidth, 0),
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
