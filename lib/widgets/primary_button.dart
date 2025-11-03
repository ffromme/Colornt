import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({
    required this.text,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: HexColor('#1ABC9C'),
        padding: const EdgeInsets.symmetric(horizontal: 142, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white,fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}