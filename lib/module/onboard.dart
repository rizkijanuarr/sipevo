import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:sipevo/core.dart";
import "package:sipevo/util/theme.dart";

class OnboardPage extends StatelessWidget {
  @override
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
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                    height: 66,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.transparent.withOpacity(0.01),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                              color: AppColors.baseColor), // Warna border
                        ),
                      ),
                      onPressed: () => Get.to(() => LoginView()),
                      child: Text(
                        "CIVITAS AKEDEMIK",
                        style: buttonOnboard,
                      ),
                    ),
                  ),
                  SizedBox(height: 10), // Spasi antara tombol
                  Container(
                    width: double.infinity,
                    height: 66,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.baseColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Get.to(() => RegisterView()),
                      child: Text(
                        "MAHASISWA",
                        style: buttonOnboard,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Dengan memilih salah satu, Anda menyetujuinya Ketentuan Layanan & Kebijakan Privasi",
                    style: textOnboard,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
