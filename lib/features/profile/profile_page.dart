import 'package:flutter/material.dart';
import 'package:appbutawarna/core/theme/app_theme.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Profile',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppTheme.grayBrand,
                    shape: BoxShape.circle,
                  ),
                  child: Text('LY', style: TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.bold, fontSize: 16),),
                ),
                const SizedBox(width: 16,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lamine Yamal',
                      style: TextStyle(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'lamineishere@gmail.com',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 60,),
            Text(
              'Pengaturan Akun',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16,),
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,
                )],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person_outline, color: AppTheme.textPrimary,),
                          const SizedBox(width: 16,),
                          Text('Informasi Pribadi', style: TextStyle(color: AppTheme.textPrimary, fontSize: 16),)
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.textPrimary,),
                    ],
                  ),
                  Divider(thickness: 0.5, color: AppTheme.grayBrand),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.vpn_key_outlined, color: AppTheme.textPrimary,),
                          const SizedBox(width: 16,),
                          Text('Ganti Password', style: TextStyle(color: AppTheme.textPrimary, fontSize: 16),)
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.textPrimary,),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16,),
            Divider(thickness: 0.1, color: AppTheme.textSecondary),
            const SizedBox(height: 16,),
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,
                )],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.question_mark_outlined, color: AppTheme.textPrimary,),
                          const SizedBox(width: 16,),
                          Text('Tentang Aplikasi', style: TextStyle(color: AppTheme.textPrimary, fontSize: 16),)
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.textPrimary,),
                    ],
                  ),
                  Divider(thickness: 0.5, color: AppTheme.grayBrand),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.logout, color: AppTheme.textPrimary,),
                          const SizedBox(width: 16,),
                          Text('Keluar', style: TextStyle(color: AppTheme.textPrimary, fontSize: 16),)
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.textPrimary,),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
