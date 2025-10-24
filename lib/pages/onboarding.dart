import 'package:appbutawarna/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: SvgPicture.asset(
                'assets/images/Onboard.svg',
                fit: BoxFit.cover,
              )
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 72, horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Colorn't",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                        color: HexColor("#FFFFFF")
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 44),
                    child: Column(
                      children: [
                        Text(
                          "Ayo, Lihat Dunia!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              color: HexColor("#FFFFFF")
                          ),
                        ),

                        SizedBox(height: 12,),

                        Text(
                          "Temukan cara mudah mengenali warna di sekitar kamu lewat teknologi yang ada pada genggamanmu.",
                          style: TextStyle(
                              fontSize: 14,
                              color: HexColor("#FFFFFF")
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 32,),

                        Container(
                          height: 6,
                          width: 22,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Homepage()
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: HexColor("#FFFFFF"),
                        fixedSize: Size(282, 72),
                      ),
                      child: const Text(
                        "Mulai Sekarang",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      )
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
