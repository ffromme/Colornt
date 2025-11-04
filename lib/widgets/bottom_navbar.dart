import 'package:appbutawarna/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavbar extends StatelessWidget {
  void Function(int)? onTabChange;

  BottomNavbar({
    super.key,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 24),
      child: GNav(
        color: Colors.grey[400],
        activeColor: Colors.grey[100],
        tabBackgroundColor: AppTheme.primaryColor,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 12,
        gap: 8,
        onTabChange: (value) => onTabChange!(value),
        tabs: const [
          GButton(
            icon: Icons.camera_alt,
            text: "Foto",
          ),
          GButton(
            icon: Icons.library_books,
            text: "Kuis",
          ),
        ],
      ),
    );
  }
}
