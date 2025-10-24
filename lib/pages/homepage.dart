import 'package:appbutawarna/pages/analisisWarna.dart';
import 'package:appbutawarna/pages/kuisWarna.dart'; // ✅ TAMBAH IMPORT
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
          // Tab 1: Analisis Warna
          AnalisisWarnaPage(
            onNavbarVisibilityChanged: setNavbarVisibility,
          ),
          // Tab 2: Kuis Warna
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