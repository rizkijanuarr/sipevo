import 'package:flutter/material.dart';
import 'package:sipevo/core.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        controller.view = this;

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
                      Obx(() {
                        return controller.isLoading.value
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Container();
                      }),
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
      },
    );
  }
}
