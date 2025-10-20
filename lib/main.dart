import 'package:appbutawarna/pages/onboarding.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AppButaWarna());
}

class AppButaWarna extends StatelessWidget {
  const AppButaWarna({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Buta Warna',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Plus Jakarta Sans',
      ),
      home: Onboarding(),
    );
  }
}