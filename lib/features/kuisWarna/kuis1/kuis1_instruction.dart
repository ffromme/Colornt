import 'package:appbutawarna/core/theme/app_theme.dart';
import 'package:appbutawarna/features/kuisWarna/kuis1/kuis1_page.dart';
import 'package:appbutawarna/features/kuisWarna/widgets/instruction_page.dart';
import 'package:flutter/material.dart';

class Kuis1Instruction extends StatelessWidget {
  const Kuis1Instruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.textPrimary,
        title: Text("Identifikasi Warna", style: TextStyle(color: AppTheme.textPrimary, fontSize: 24, fontWeight: FontWeight.bold),),
      ),
      body: instruction_page(
        image: "assets/images/kuis1.png",
        instruksi: "1. Kotak berwarna akan muncul sebagai soal\n2. Pilih opsi yang menurut pandangan anda benar",
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Kuis1Page(),
          )
        ),
      ),
    );
  }
}