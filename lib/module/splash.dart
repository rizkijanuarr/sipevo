import "dart:async";

import "package:flutter/material.dart";
import "package:sipevo/module/onboard.dart";
import "package:sipevo/util/theme.dart";

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // INISIASI VARIABLE
  bool isLoading = true;

// MENAMBAHKAN TIMER UNTUK SPLASHSCREEN DISINI YAAW!
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnboardPage(),
        ),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/onboard.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // MEMPOSISIKAN PADA CENTER FLUTTER
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "SIPEVO",
                    style: titleSplash,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Melayani informasi sarana dan prasarana pada Vokasi",
                    style: subtitleSplash,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  if (isLoading)
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                ],
              ),
            ),
          ),

          // MEMPOSISIKAN PARENT BOTTOM BAWAH FLUTTER
          Column(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/logo-unesa.png",
                              width: 60,
                              height: 60,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Image.asset(
                              "assets/logo-vokasi.png",
                              width: 100,
                              height: 100,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Image.asset(
                              "assets/zee.png",
                              width: 70,
                              height: 70,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}