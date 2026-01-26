import 'package:appbutawarna/core/theme/app_theme.dart';
import 'package:appbutawarna/features/kuisWarna/widgets/instruction_page.dart';
import 'package:appbutawarna/features/kuisWarna/kuis2/kuis2_page.dart';
import 'package:flutter/material.dart';

class Kuis2Instruction extends StatelessWidget {
  const Kuis2Instruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.textPrimary,
        title: Text("Susun Gradasi Warna", style: TextStyle(color: AppTheme.textPrimary, fontSize: 24, fontWeight: FontWeight.bold),),
      ),
      body: instruction_page(
        image: "assets/images/kuis2.png",
        instruksi: "1. Soal berupa kotak yang tersusun secara vertikal di sebelah kiri\n2. Kotak paling atas dan paling bawah akan diisi warna yang berbeda\n3. Seret kotak-kotak berwarna pada sebelah kanan ke kotak-kotak tidak berwarna di kiri sehingga menciptakan gradasi warna yang benar",
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Kuis2Page(),
            )
        ),
      ),
    );
  }
}
