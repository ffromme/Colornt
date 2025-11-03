import 'package:appbutawarna/pages/loginPage.dart';
import 'package:appbutawarna/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 72),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Colorn't",
                  style: TextStyle(color: HexColor('#1ABC9C'), fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Text(
              "Membantu Anda melihat dunia dengan penuh warna!",
              textAlign: TextAlign.center,
              style: TextStyle(color: HexColor('#7F8C8D'), fontSize: 16),
            ),

            const SizedBox(height: 100),

            Image.asset(
              'assets/images/imgOnboard.png',
              height: 300,
            ),

            const SizedBox(height: 100),

            PrimaryButton(text: 'Mulai', onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            }),

            const SizedBox(height: 12),

            Text(
              "Belum punya akun? Daftar",
              style: TextStyle(color: HexColor('#B5B5B5'), fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      )
    );
  }
}


