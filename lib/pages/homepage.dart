import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _openCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
      // di sini kamu bisa lanjut kirim ke LLM atau tampilkan preview-nya
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // tampilkan hasil foto (jika sudah ada)
            if (_image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    _image!,
                    width: 300,
                    height: 400,
                    fit: BoxFit.cover,
                  )
              )
            else
              ElevatedButton(
                  onPressed: _openCamera,
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: HexColor('#1ABC9C'),
                      fixedSize: Size(200, 200)
                  ),
                  child: Image.asset('assets/img/Camera.png', width: 90,)
              ),
          ],
        ),
      ),
    );
  }
}
