import 'package:appbutawarna/pages/home/analisis_warna.dart';
import 'package:appbutawarna/pages/home/kuis_warna.dart';
import 'package:appbutawarna/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  bool _hideNavbar = false;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
      if (_hideNavbar) {
        _hideNavbar = false;
      }
    });
  }

  void setNavbarVisibility(bool hide) {
    if (_hideNavbar != hide) {
      setState(() {
        _hideNavbar = hide;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          AnalisisWarnaPage(
            onNavbarVisibilityChanged: setNavbarVisibility,
          ),
          const KuisWarnaPage(),
        ],
      ),
      bottomNavigationBar: _hideNavbar
          ? null
          : BottomNavbar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
    );
  }
}