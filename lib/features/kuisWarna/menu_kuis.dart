import 'package:appbutawarna/core/theme/app_theme.dart';
import 'package:appbutawarna/features/kuisWarna/kuis1/kuis1_instruction.dart';
import 'package:flutter/material.dart';
import 'package:appbutawarna/features/kuisWarna/widgets/card_kategori_kuis.dart';
import 'package:appbutawarna/features/kuisWarna/data/data_kategori.dart';

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
                fontSize: 14,
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

                    // Kuis 1: Identifikasi Warna
                    CardKategoriKuis(
                        kategori: kategoriKuis[0],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Kuis1Instruction(),
                            settings: RouteSettings(name: 'Kuis1Instruksi')
                          ),
                        )
                    ),

                    const SizedBox(width: 16,),

                    // Kuis 2: Susun Gradasi Warna
                    CardKategoriKuis(kategori: kategoriKuis[1], onTap: () {}),

                    const SizedBox(width: 16,),

                    // Kuis 3: Cari yang Berbeda
                    CardKategoriKuis(kategori: kategoriKuis[2], onTap: () {}),

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


