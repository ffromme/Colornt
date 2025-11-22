import 'package:appbutawarna/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item(
            icon: Icons.camera_alt,
            index: 0,
            isActive: currentIndex == 0,
          ),
          _item(
            icon: Icons.menu_book_outlined,
            index: 1,
            isActive: currentIndex == 1,
          ),
          _item(
            icon: Icons.history,
            index: 2,
            isActive: currentIndex == 2,
          ),
          _item(
            icon: Icons.person,
            index: 3,
            isActive: currentIndex == 3,
          ),
        ],
      ),
    );
  }

  Widget _item({required IconData icon, required int index, required bool isActive}) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Icon(
        icon,
        size: 24,
        color: isActive ? AppTheme.primaryColor : AppTheme.textSecondary,
      ),
    );
  }
}
