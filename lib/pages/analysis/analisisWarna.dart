import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:appbutawarna/services/gemini_service.dart';

class AnalisisWarnaPage extends StatefulWidget {
  final Function(bool)? onNavbarVisibilityChanged;

  const AnalisisWarnaPage({
    super.key,
    this.onNavbarVisibilityChanged,
  });

  @override
  State<AnalisisWarnaPage> createState() => _AnalisisWarnaPageState();
}

class _AnalisisWarnaPageState extends State<AnalisisWarnaPage> {
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

      widget.onNavbarVisibilityChanged?.call(true);

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

      setState(() {
        _isAnalyzing = false;
      });

      widget.onNavbarVisibilityChanged?.call(false);

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

    widget.onNavbarVisibilityChanged?.call(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _image != null
          ? AppBar(
        title: const Text(
          "Hasil Analisis",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: HexColor('#1ABC9C'),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _retakeFoto,
        ),
      )
          : null,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_image == null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 32.0),
                      child: Text(
                        "Analisis Warna",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),

                  // Tampilkan hasil foto
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

                        const SizedBox(height: 24),

                        // Loading state
                        if (_isAnalyzing)
                          Column(
                            children: [
                              CircularProgressIndicator(
                                color: HexColor('#1ABC9C'),
                                strokeWidth: 3,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                "Menganalisis gambar...",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Mohon tunggu sebentar",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        else if (_analysisResult != null && _analysisResult!.isNotEmpty)
                          Container(
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
                                    const SizedBox(width: 12),
                                    const Text(
                                      "Analisis Warna",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 16),
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

                        const SizedBox(height: 24),

                        ElevatedButton.icon(
                          onPressed: _isAnalyzing ? null : _retakeFoto,
                          icon: const Icon(Icons.camera_alt),
                          label: const Text("Ambil Foto Lagi"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: HexColor('#1ABC9C'),
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: Colors.grey[400],
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
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
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: _openCamera,
                              borderRadius: BorderRadius.circular(24),
                              child: Center(
                                child: Image.asset(
                                  'assets/img/Camera.png',
                                  width: 90,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.camera_alt,
                                      size: 90,
                                      color: Colors.white,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          "Ketuk untuk mengambil foto",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
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