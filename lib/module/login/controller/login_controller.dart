import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sipevo/app_routes.dart';
import 'package:sipevo/core.dart';
import 'package:sipevo/shared_prefs_helper.dart';
import '../view/login_view.dart';

class LoginController extends GetxController {
  LoginView? view;

  // KEBUTUHAN visible password
  bool showPassword = false;

  void togglePasswordVisibility() {
    showPassword = !showPassword;
    update();
  }
  // KEBUTUHAN visible password

  void navigateBasedOnRole(String role) {
    switch (role) {
      case 'admin':
        Get.offAll(() => NavAdmin()); // Beranda Admin
        break;
      case 'operator':
        Get.offAll(() => NavbaropView()); // Beranda OP
        break;
      case 'mahasiswa':
        Get.offAll(() => NavbarmhsView()); // Beranda Mahasiswa
        break;
      default:
        Get.offAll(
            () => LoginView()); // Back to LoginView jika role tidak dikenali
    }
  }

  // KEBUTUHAN LOGIN USER
  var formKey = GlobalKey<FormState>();
  var controllerNohp = TextEditingController();
  var controllerPassword = TextEditingController();

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      print("Phone: ${controllerNohp.text}");
      print("Password: ${controllerPassword.text}");
      print('URL: ${AppRoutes.login}');
      print('Headers: ${{'Content-Type': 'application/json'}}');
      print('Body: ${jsonEncode({
            'phone': controllerNohp.text,
            'password': controllerPassword.text
          })}');
      try {
        final response = await http.post(
          Uri.parse(AppRoutes.login),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'phone': controllerNohp.text,
            'password': controllerPassword.text,
          }),
        );

        print("Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");

        final responseData = jsonDecode(response.body);

        if (response.statusCode == 200) {
          String token = responseData['token'];
          String role = responseData['role'];

          await SharedPrefsHelper.setToken(token);
          await SharedPrefsHelper.setUserRole(role);

          print("Token: $token");
          print("Role: $role");

          navigateBasedOnRole(role); // Navigasi
        } else {
          String errorMessage =
              responseData['message'] ?? 'Login failed, please try again.';
          Get.snackbar('Error', errorMessage);
        }
      } catch (e) {
        Get.snackbar('Error', 'An error occurred: $e');
      } finally {
        controllerNohp.clear();
        controllerPassword.clear();
      }
    }
  }

  // LAST
}
