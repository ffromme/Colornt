import 'package:appbutawarna/core/theme/app_theme.dart';
import 'package:appbutawarna/core/widgets/card_kategori_kuis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MenuKuis extends StatelessWidget {
  const MenuKuis({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Menu Kuis',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: AppTheme.backgroundColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Pilih kategori kuis yang sudah disediakan.',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 80,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardKategoriKuis(
                        title: "Identifikasi Warna",
                        description: "Coba tebak warna yang ditampilkan \nuntuk menguji kemampuan mengenali \nwarna dasar.",
                        image: 'assets/images/kuis1.png'
                    ),
                    const SizedBox(width: 16,),
                    CardKategoriKuis(
                        title: "Susun Gradasi Warna",
                        description: "Urutkan warna dari satu warna ke warna \nlain untuk mendeteksi pola buta warna \nsecara lebih akurat.",
                        image: 'assets/images/kuis2.png'
                    ),
                    const SizedBox(width: 16,),
                    CardKategoriKuis(
                        title: "Cari yang Berbeda",
                        description: "Temukan warna yang berbeda di antara \nwarna-warna mirip untuk menguji \nsensitivitas penglihatan warna.",
                        image: 'assets/images/kuis3.png'
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


