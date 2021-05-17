import 'package:campus_share/Screens/account.dart';
import 'package:campus_share/Screens/myAds.dart';
import 'package:campus_share/Screens/sell.dart';
import 'package:campus_share/Screens/share.dart';
import 'package:flutter/material.dart';

import 'Home.dart';

class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screens = [
    Home(),
    Share(),
    Sell(),
    MyAds(),
    Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _screens.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.share_outlined),
              label: 'SHARE',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on_outlined),
              label: 'SELL',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'MY ADS',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity),
              label: 'ACCOUNT',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blueGrey[900],
          unselectedItemColor: Colors.blueGrey[400],
          showUnselectedLabels: true,
          elevation: 0,
          type: BottomNavigationBarType.shifting,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
