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
                'assets/img/Onboard.svg',
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
                    padding: const EdgeInsets.symmetric(horizontal: 48),
                    child: Column(
                      children: [
                        Text(
                          "Lihat!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              color: HexColor("#FFFFFF")
                          ),
                        ),

                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed volutpat sed est sit amet commodo.",
                          style: TextStyle(
                              fontSize: 14,
                              color: HexColor("#FFFFFF")
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 24,),

                        Container(
                          height: 4,
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
                            builder: (context) => const Homepage()
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: HexColor("#FFFFFF"),
                        fixedSize: Size(282, 72),
                      ),
                      child: const Text(
                        "Ayo Melihat dan Merasakan",
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
