import 'package:flutter/material.dart';
import 'package:oops/screens/home/profile.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List _screens = [Scaffold(), Scaffold(), Scaffold(), Profile()];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: _screens[_index],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            currentIndex: _index,
            onTap: (int index) => setState(() => _index = index),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.blueAccent[700],
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            elevation: 0.0,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 30,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.emoji_events,
                    size: 30,
                  ),
                  label: 'Estatísticas'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.emoji_flags,
                    size: 30,
                  ),
                  label: 'Rank'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 30,
                  ),
                  label: 'Perfil'),
            ],
          ),
        ),
      ),
    );
  }
}
