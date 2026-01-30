import 'dart:io';
import 'package:appbutawarna/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:appbutawarna/services/gemini_service.dart';
import 'package:appbutawarna/services/analysis_history_service.dart';

class AnalisisWarnaPage extends StatefulWidget {

  const AnalisisWarnaPage({
    super.key,
  });

  @override
  State<AnalisisWarnaPage> createState() => _AnalisisWarnaPageState();
}

class _AnalisisWarnaPageState extends State<AnalisisWarnaPage> {
  File? _image;
  String? _analysisResult;
  bool _isAnalyzing = false;
  late final AnalysisHistoryService _historyService;
  bool _isSavingHistory = false;

  final ImagePicker _picker = ImagePicker();
  late final GeminiService _geminiService;

  @override
  void initState() {
    super.initState();
    try {
      _geminiService = GeminiService();
      _historyService = AnalysisHistoryService();
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

  Future<void> _saveToHistory() async {
    if (_image == null || _analysisResult == null || _analysisResult!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tidak ada hasil analisis untuk disimpan'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isSavingHistory = true;
    });

    try {
      await _historyService.saveAnalysis(
        imageFile: _image!,
        analysisResult: _analysisResult!,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Berhasil disimpan ke riwayat'),
          backgroundColor: AppTheme.primaryColor,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSavingHistory = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Analisis Warna",
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Tampilkan hasil foto
                  if (_image != null)
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(28),
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
                                color: AppTheme.primaryColor,
                                strokeWidth: 3,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Menganalisis gambar...",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Mohon tunggu sebentar",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          )

                          // Hasil analisis
                        else if (_analysisResult != null && _analysisResult!.isNotEmpty)
                          Container(
                            width: MediaQuery.of(context).size.width - 48,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(color: AppTheme.textSecondary.withOpacity(0.25), width: 1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.palette,
                                      color: AppTheme.primaryColor,
                                      size: 24,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      "Hasil Analisis Warna",
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
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        const SizedBox(height: 24),

                        // Tombol ambil foto lagi
                        SizedBox(
                          width: 180,
                          height: 56,
                          child: ElevatedButton.icon(
                            onPressed: _isAnalyzing ? null : _retakeFoto,
                            icon: const Icon(Icons.camera_alt),
                            label: const Text("Foto Lagi"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              foregroundColor: Colors.white,
                              disabledBackgroundColor: Colors.grey[400],
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                              elevation: 0,
                            ),
                          ),
                        ),

                        SizedBox(height: 16,),

                        // Tombol simpan hasil
                        SizedBox(
                          width: 180,
                          height: 56,
                          child: ElevatedButton.icon(
                            onPressed: _isAnalyzing || _isSavingHistory ? null : _saveToHistory,
                            icon: _isSavingHistory
                                ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.save_alt_rounded),
                            label: Text(_isSavingHistory ? "Menyimpan..." : "Simpan hasil"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              foregroundColor: Colors.white,
                              disabledBackgroundColor: Colors.grey[400],
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                              elevation: 0,
                            ),
                          ),
                        ),
                      ],
                    )

                    // Foto belum diambil
                  else
                    Column(
                      children: [
                        const SizedBox(height: 16,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: _openCamera,
                              child: Container(
                                width: 240,
                                height: 240,
                                decoration: BoxDecoration(
                                  color: HexColor('#F3F4F6'),
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.image, color: AppTheme.textSecondary,),
                                    Text(
                                      "Ketuk untuk ambil foto",
                                      style: TextStyle(
                                        color: AppTheme.textSecondary,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Container teks hasil analisis
                        Container(
                          width: MediaQuery.of(context).size.width - 32,
                          height: 380,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(color: AppTheme.textSecondary.withOpacity(0.25), width: 1),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Teks hasil analisis akan muncul di sini.",
                                  style: TextStyle(
                                    color: AppTheme.textSecondary,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
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