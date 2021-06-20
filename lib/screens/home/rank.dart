import 'package:flutter/material.dart';

class Rank extends StatefulWidget {
  @override
  _RankState createState() => _RankState();
}

class _RankState extends State<Rank> {
  List<Map<String, String>> _firstThree = [
    {'position': '1', 'name': 'Daniel M Brasil'},
    {'position': '2', 'name': 'Heidy Simbaqueaba'},
    {'position': '3', 'name': 'Willy'}
  ];

  List<Map<String, String>> _rank = [
    {'position': '4', 'name': 'Whatsapp Jr'},
    {'position': '5', 'name': 'Telegram Jr'},
    {'position': '6', 'name': 'Mr LinkedIn'},
    {'position': '7', 'name': 'Nubank Jr'},
    {'position': '8', 'name': 'Nubank Jr'},
    {'position': '9', 'name': 'Nubank Jr'},
    {'position': '10', 'name': 'Nubank Jr'},
    {'position': '11', 'name': 'Nubank Jr'},
    {'position': '12', 'name': 'Nubank Jr'},
    {'position': '13', 'name': 'Nubank Jr'},
    {'position': '14', 'name': 'Nubank Jr'},
    {'position': '15', 'name': 'Nubank Jr'},
    {'position': '16', 'name': 'Nubank Jr'},
    {'position': '17', 'name': 'Nubank Jr'},
    {'position': '18', 'name': 'Nubank Jr'},
  ];

  @override
  Widget build(BuildContext context) {
    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          SizedBox(height: 20),
          Container(
            width: _screenWidth,
            height: _screenHeight * 0.35,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: InkWell(
                    child: Container(
                      width: _screenWidth * 0.18,
                      height: _screenHeight * 0.18,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/gold.png'),
                        ),
                      ),
                    ),
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) => _buildDialog(
                              context,
                              _firstThree.elementAt(0)['name'],
                              'gold.png',
                              _screenWidth));
                    },
                  ),
                ),
                Positioned(
                  left: 20,
                  bottom: 0,
                  child: InkWell(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: _screenWidth * 0.25,
                      height: _screenHeight * 0.25,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/plate.png'),
                        ),
                      ),
                    ),
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) => _buildDialog(
                              context,
                              _firstThree.elementAt(1)['name'],
                              'plate.png',
                              _screenWidth));
                    },
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 0,
                  child: InkWell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      width: _screenWidth * 0.25,
                      height: _screenHeight * 0.25,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/silver.png'),
                        ),
                      ),
                    ),
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) => _buildDialog(
                              context,
                              _firstThree.elementAt(2)['name'],
                              'silver.png',
                              _screenWidth));
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: _rank.length * 57.0,
            width: _screenWidth,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                ..._rank.map(
                  (e) => ListTile(
                    leading: Text(
                      e['position'],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    title: Text(
                      e['name'],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    trailing: Icon(
                      Icons.star,
                      size: 30,
                      color: Colors.yellow[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}

Widget _buildDialog(
    BuildContext context, String name, String medal, double screenWidth) {
  return AlertDialog(
    content: Container(
      width: screenWidth,
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/' + medal),
                ),
              )),
          Text(
            name,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Fechar',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
