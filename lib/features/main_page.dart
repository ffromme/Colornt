import 'package:appbutawarna/core/widgets/bottom_navbar.dart';
import 'package:appbutawarna/features/analisisWarna/analisis_warna_page.dart';
import 'package:appbutawarna/features/kuisWarna/menu_kuis.dart';
import 'package:appbutawarna/features/profile/profile_page.dart';
import 'package:appbutawarna/features/riwayat/menu_riwayat.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _HomePageState();
}

class _HomePageState extends State<MainPage> {
  int index = 0;

  final pages = const [
    AnalisisWarnaPage(),
    MenuKuis(),
    MenuRiwayat(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavBar(
        currentIndex: index,
        onTap: (i) {
          setState(() => index = i);
        },
      ),
    );
  }
}
