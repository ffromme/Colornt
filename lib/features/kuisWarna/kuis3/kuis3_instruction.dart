import 'package:appbutawarna/core/theme/app_theme.dart';
import 'package:appbutawarna/features/kuisWarna/kuis3/kuis3_page.dart';
import 'package:appbutawarna/features/kuisWarna/widgets/instruction_page.dart';
import 'package:flutter/material.dart';

class Kuis3Instruction extends StatelessWidget {
  const Kuis3Instruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.textPrimary,
        title: Text("Cari yang Berbeda", style: TextStyle(color: AppTheme.textPrimary, fontSize: 24, fontWeight: FontWeight.bold),),
      ),
      body: instruction_page(
        image: "assets/images/kuis3.png",
        instruksi: "1. Soal berupa susunan kotak 5x5 berwarna\n2. Temukan dan pilih satu kotak yang warnanya berbeda dari yang lain",
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Kuis3Page(),
            )
        ),
      ),
    );
  }
}