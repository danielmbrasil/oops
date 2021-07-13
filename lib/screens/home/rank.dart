import 'package:flutter/material.dart';
import 'package:oops/screens/shared/wave_loading.dart';
import 'package:oops/services/users.dart';

class Rank extends StatefulWidget {
  @override
  _RankState createState() => _RankState();
}

class _RankState extends State<Rank> {
  bool _loading = true;

  List<Map<String, dynamic>> _rank = [];

  void _fetchUsers() async {
    try {
      var users = await UsersService().fetchUsers();
      setState(() {
        _rank = List.from(users);
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUsers();
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
                          onTap: _rank.length > 0
                              ? () async {
                                  await showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          _buildDialog(
                                              context,
                                              _rank.elementAt(0)['name'],
                                              'gold.png',
                                              _screenWidth));
                                }
                              : null,
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
                          onTap: _rank.length > 1
                              ? () async {
                                  await showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          _buildDialog(
                                              context,
                                              _rank.elementAt(1)['name'],
                                              'plate.png',
                                              _screenWidth));
                                }
                              : null,
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
                          onTap: _rank.length > 2
                              ? () async {
                                  await showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          _buildDialog(
                                              context,
                                              _rank.elementAt(2)['name'],
                                              'silver.png',
                                              _screenWidth));
                                }
                              : null,
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
                  child: _rank.length < 2
                      ? Container()
                      : Column(
                          children: [
                            ..._rank
                                .sublist(3)
                                .asMap()
                                .map(
                                  (i, e) => MapEntry(
                                    i,
                                    ListTile(
                                      leading: Text(
                                        (i + 4).toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      title: Text(
                                        e['name'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      trailing: Icon(
                                        Icons.star,
                                        size: 30,
                                        color: Colors.yellow[700],
                                      ),
                                    ),
                                  ),
                                )
                                .values
                                .toList(),
                          ],
                        ),
                ),
                SizedBox(height: 50),
              ],
            ),
          );
  }
}

/// Builds dialog for top 3 with their medal and name
/// @param 1: BuildContext
/// @param 2: user's name
/// @param 3: user's medal (i.e., gold, plate, silver) followed by .png
/// @param 4: width of screen returned by MediaQuery
///
/// @return AlertDialog with user's medal and their name
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
