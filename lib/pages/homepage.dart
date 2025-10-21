import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:appbutawarna/services/gemini_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  File? _image;
  String? _analysisResult;
  bool _isAnalyzing = false;

  final ImagePicker _picker = ImagePicker();
  late final GeminiService _geminiService;

  @override
  void initState() {
    super.initState();
    try {
      _geminiService = GeminiService();
    } catch (e) {
      // Handle error saat inisialisasi service
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error inisialisasi: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
    }
  }

  Future<void> _openCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (image == null) {
        return;
      }

      if (!mounted) return;

      setState(() {
        _image = File(image.path);
        _isAnalyzing = true;
        _analysisResult = null;
      });

      try {
        final result = await _geminiService.analyzeImage(File(image.path));

        if (!mounted) return;

        setState(() {
          _analysisResult = result;
          _isAnalyzing = false;
        });
      } catch (e) {
        if (!mounted) return;

        setState(() {
          _analysisResult = 'Terjadi kesalahan saat menganalisis: ${e.toString()}';
          _isAnalyzing = false;
        });
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error membuka kamera: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _retakeFoto() {
    setState(() {
      _image = null;
      _analysisResult = null;
      _isAnalyzing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _image != null
        ? AppBar(
        title: const Text("Hasil Analisis", style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: HexColor('#1ABC9C'),
        foregroundColor: Colors.white,
        elevation: 0,
      )
      : null,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // tampilkan hasil foto (jika sudah ada)
                if (_image != null)
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(
                          _image!,
                          width: 300,
                          height: 400,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 300,
                              height: 400,
                              color: Colors.grey[300],
                              child: const Center(
                                child: Text(
                                  'Gagal memuat gambar',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      if (_isAnalyzing)
                        Column(
                          children: [
                            CircularProgressIndicator(
                              color: HexColor('#1ABC9C'),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                                "Menganalisis gambar...",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                            ),
                          ],
                        )
                      else if (_analysisResult != null && _analysisResult!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.palette,
                                      color: HexColor('#1ABC9C'),
                                      size: 24,
                                    ),

                                    SizedBox(width: 12,),

                                    const Text(
                                      "Analisis Warna",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  _analysisResult!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    height: 1.6,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ElevatedButton.icon(
                            onPressed: _isAnalyzing ? null : _retakeFoto,
                            icon: const Icon(Icons.camera_alt),
                            label: const Text("Ambil Foto Lagi"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: HexColor('#1ABC9C'),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                              ),
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                        ),
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: HexColor('#1ABC9C'),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: HexColor('#1ABC9C').withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _openCamera,
                            borderRadius: BorderRadius.circular(20),
                            child: Center(
                              child: Image.asset(
                                'assets/images/Camera.png',
                                width: 90,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 32,),

                      const Text(
                        "Ketuk untuk mengambil foto",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _geminiService.dispose();
    super.dispose();
  }
}
