import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mykey/pages/About.dart';
import 'package:mykey/pages/AddKey.dart';
import 'package:mykey/pages/KeyList.dart';
import 'package:mykey/pages/Settings.dart';
import '../services/couleurs.dart';
import 'SocialPage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [Settings(), KeyList(), AddKey(), About()];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: primar_color,
          title: SizedBox(
            height: kToolbarHeight,
            child: Image.asset(
              'assets/images/logo1.jpg',
              fit: BoxFit.contain,
            ),
          ),
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: CurvedNavigationBar(
          animationDuration: Duration(milliseconds: 300),
          height: 55,
          color: primar_color,
          backgroundColor: Colors.white,
          onTap: _navigateBottomBar,
          items: [
            Icon(
              Icons.settings,
              color: whit_color,
              size: 40,
            ),
            Icon(
              Icons.list,
              color: whit_color,
              size: 40,
            ),
            Icon(
              Icons.add,
              color: whit_color,
              size: 40,
            ),
            Icon(
              Icons.info,
              color: whit_color,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
