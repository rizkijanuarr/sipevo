import 'package:flutter/material.dart';
import '../controller/profile_controller.dart' as beranda; // Alias added here
import 'package:sipevo/core.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<beranda.ProfileController>(
      // Use the alias here
      init: beranda.ProfileController(), // And here
      builder: (controller) {
        controller.view = this;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
            actions: [
              IconButton(
                onPressed: () async {
                  await SharedPrefsHelper
                      .removeToken(); // Memanggil metode untuk menghapus token
                  Get.offAllNamed(
                      '/login'); // Mengarahkan pengguna ke halaman login atau halaman awal
                },
                icon: const Icon(
                  Icons.logout,
                  size: 24.0,
                ),
              ),
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: const Column(
                children: [
                  Text(
                    "COMMING SOON!👀",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Color(0xff0f9565),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
