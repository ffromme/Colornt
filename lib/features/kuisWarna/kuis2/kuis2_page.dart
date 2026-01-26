import 'package:appbutawarna/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:appbutawarna/features/kuisWarna/kuis2/providers/kuis2_provider.dart';
import 'kuis2_result_page.dart';

class Kuis2Page extends StatefulWidget {
  const Kuis2Page({super.key});

  @override
  State<Kuis2Page> createState() => _Kuis2PageState();
}

class _Kuis2PageState extends State<Kuis2Page> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Load soal saat widget pertama kali dibuat
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<Kuis2Provider>();
      if (!_isInitialized) {
        provider.loadRandomQuestion();
        setState(() {
          _isInitialized = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Susun Gradasi Warna',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<Kuis2Provider>(
        builder: (context, provider, child) {
          if (!_isInitialized || provider.currentQuestion == null) {
            return Center(
              child: CircularProgressIndicator(
                color: AppTheme.primaryColor,
              ),
            );
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        // Kolom kiri: Slot gradasi
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(8, (index) {
                              return _buildGradientSlot(
                                context,
                                provider,
                                index,
                              );
                            }),
                          ),
                        ),

                        SizedBox(width: 24),

                        // Kolom kanan: Warna yang tersedia
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: provider.availableColors.map((color) {
                              return _buildDraggableColor(color);
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24),

                  // Tombol Selesai
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: provider.allSlotsFilled
                          ? () {
                        provider.submitAnswer();
                        provider.saveQuizResult();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Kuis2ResultPage(),
                          ),
                        );
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        disabledBackgroundColor: Colors.grey[300],
                        padding: EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(64),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Selesai',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: provider.allSlotsFilled
                              ? Colors.white
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Slot gradasi di kiri
  Widget _buildGradientSlot(
      BuildContext context,
      Kuis2Provider provider,
      int index,
      ) {
    // Slot pertama dan terakhir tidak bisa diisi (fixed)
    final isFixed = index == 0 || index == 7;
    final color = provider.getSlotColor(index);

    if (isFixed) {
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
      );
    }

    // Slot yang bisa diisi (target)
    return DragTarget<Color>(
      onAccept: (droppedColor) {
        provider.fillSlot(index, droppedColor);
      },
      builder: (context, candidateData, rejectedData) {
        final bool isHovering = candidateData.isNotEmpty;

        return GestureDetector(
          onTap: () {
            // Tap untuk remove color dari slot
            if (color != null) {
              provider.removeFromSlot(index);
            }
          },
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color ?? Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
              border: isHovering
                  ? Border.all(
                color: HexColor('#3498DB'),
                width: 3,
              )
                  : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Warna yang bisa di-drag di kanan
  Widget _buildDraggableColor(Color color) {
    return Draggable<Color>(
      data: color,
      feedback: Material(
        color: Colors.transparent,
        child: Opacity(
          opacity: 0.7,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          ),
        ),
      ),
      childWhenDragging: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
      ),
    );
  }
}