import 'package:flutter/material.dart';
import 'package:appbutawarna/core/theme/app_theme.dart';
import 'package:appbutawarna/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appbutawarna/features/auth/login_page.dart';
import 'package:appbutawarna/core/utils/snackbar_helper.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    setState(() {
      _currentUser = _authService.currentUser;
    });
  }

  String _getInitials(String? displayName, String? email) {
    if (displayName != null && displayName.isNotEmpty) {
      final names = displayName.trim().split(' ');
      if (names.length >= 2) {
        return '${names[0][0]}${names[1][0]}'.toUpperCase();
      } else if (names.isNotEmpty) {
        return names[0].substring(0, names[0].length >= 2 ? 2 : 1).toUpperCase();
      }
    }

    if (email != null && email.isNotEmpty) {
      return email.substring(0, 2).toUpperCase();
    }

    return 'US';
  }

  String _getDisplayName() {
    if (_currentUser?.displayName != null && _currentUser!.displayName!.isNotEmpty) {
      return _currentUser!.displayName!;
    }
    return 'Pengguna';
  }

  String _getEmail() {
    return _currentUser?.email ?? 'Email tidak tersedia';
  }

  Future<void> _handleLogout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi Keluar'),
        content: Text('Apakah Anda yakin ingin keluar dari akun?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Text('Keluar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await _authService.signOut();

        if (!mounted) return;

        SnackBarHelper.showSuccess(context, 'Berhasil keluar');

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false,
        );
      } catch (e) {
        if (!mounted) return;
        SnackBarHelper.showError(context, 'Gagal keluar: ${e.toString()}');
      }
    }
  }

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
      body: _currentUser == null
          ? Center(
        child: CircularProgressIndicator(
          color: AppTheme.primaryColor,
        ),
      )
          : Padding(
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
                  child: Text(
                    _getInitials(_currentUser?.displayName, _currentUser?.email),
                    style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getDisplayName(),
                        style: TextStyle(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        _getEmail(),
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Text(
              'Pengaturan Akun',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: AppTheme.grayBrand,
                  width: 2,
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      // TODO: Navigasi ke halaman informasi pribadi
                      SnackBarHelper.showInfo(
                        context,
                        'Fitur Informasi Pribadi sedang dalam pengembangan',
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person_outline,
                              color: AppTheme.textPrimary,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Informasi Pribadi',
                              style: TextStyle(
                                color: AppTheme.textPrimary,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: AppTheme.textPrimary,
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 0.5, color: AppTheme.grayBrand),
                  InkWell(
                    onTap: () {
                      // TODO: Navigasi ke halaman ganti password
                      SnackBarHelper.showInfo(
                        context,
                        'Fitur Ganti Password sedang dalam pengembangan',
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.vpn_key_outlined,
                              color: AppTheme.textPrimary,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Ganti Password',
                              style: TextStyle(
                                color: AppTheme.textPrimary,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: AppTheme.textPrimary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Divider(thickness: 1, color: AppTheme.grayBrand),
            const SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: AppTheme.grayBrand,
                  width: 2,
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      // TODO: Navigasi ke halaman tentang aplikasi
                      SnackBarHelper.showInfo(
                        context,
                        'Fitur Tentang Aplikasi sedang dalam pengembangan',
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.question_mark_outlined,
                              color: AppTheme.textPrimary,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Tentang Aplikasi',
                              style: TextStyle(
                                color: AppTheme.textPrimary,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: AppTheme.textPrimary,
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 0.5, color: AppTheme.grayBrand),
                  InkWell(
                    onTap: _handleLogout,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: AppTheme.textPrimary,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Keluar',
                              style: TextStyle(
                                color: AppTheme.textPrimary,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: AppTheme.textPrimary,
                        ),
                      ],
                    ),
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