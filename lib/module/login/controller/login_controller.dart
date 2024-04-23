import 'dart:convert'; // Import ini diperlukan untuk jsonEncode

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sipevo/app_routes.dart';
import 'package:sipevo/module/admin/beranda/view/beranda_view.dart';
import 'package:sipevo/shared_prefs_helper.dart';
import '../view/login_view.dart';

class LoginController extends GetxController {
  LoginView? view;

  var controllerNohp = TextEditingController();
  var controllerPassword = TextEditingController();
  var formKey = GlobalKey<FormState>();

  void navigateBasedOnRole(String role) {
    switch (role) {
      case 'admin':
        Get.off(const BerandaView()); // Navigasi ke Beranda Admin
        break;
      // Tambahkan case untuk role lainnya
      default:
        Get.off(
            const LoginView()); // Kembali ke LoginView jika role tidak dikenali
    }
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      print("Phone: ${controllerNohp.text}"); // Menampilkan nomor telepon
      print("Password: ${controllerPassword.text}"); // Menampilkan password
      print('URL: ${AppRoutes.login}');
      print('Headers: ${{'Content-Type': 'application/json'}}');
      print('Body: ${jsonEncode({
            'phone': controllerNohp.text,
            'password': controllerPassword.text
          })}');
      try {
        // Form valid, kirim request ke backend dengan header untuk JSON
        final response = await http.post(
          Uri.parse(AppRoutes.login),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'phone': controllerNohp.text,
            'password': controllerPassword.text,
          }),
        );

        final responseData = jsonDecode(response.body);

        if (response.statusCode == 200) {
          // Login berhasil, simpan token dan role
          String token = responseData['token'];
          String role = responseData['role']; // Asumsi role dikirim dari server

          await SharedPrefsHelper.setToken(token);
          await SharedPrefsHelper.setUserRole(role); // Simpan role pengguna

          print("Token: $token");
          print("Role: $role");

          // Navigasi berdasarkan role
          navigateBasedOnRole(role);
        } else {
          // Login gagal, tampilkan pesan kesalahan dari server
          String errorMessage =
              responseData['message'] ?? 'Login failed, please try again.';
          Get.snackbar('Error', errorMessage);
        }
      } catch (e) {
        // Menangkap error dan menampilkan snackbar
        Get.snackbar('Error', 'An error occurred: $e');
      } finally {
        // Clear text fields setelah login
        controllerNohp.clear();
        controllerPassword.clear();
      }
    }
  }
}
