import 'package:appbutawarna/core/theme/app_theme.dart';
import 'package:appbutawarna/features/kuisWarna/models/kategori_kuis.dart';
import 'package:flutter/material.dart';

class CardKategoriKuis extends StatelessWidget {
  final KategoriKuis kategori;
  final VoidCallback onTap;

  const CardKategoriKuis({
    super.key,
    required this.kategori,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(16),
            width: 300,
            height: 400,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Image.asset(
                kategori.image,
            ),
          ),
        ),

        const SizedBox(height: 12,),

        Text(
          kategori.title,
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),

        const SizedBox(height: 8,),

        Text(
          kategori.description,
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 16,
          ),
        )
      ],
    );
  }
}