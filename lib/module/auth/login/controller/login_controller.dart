import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sipevo/core.dart';

class LoginController extends GetxController {
  LoginView? view;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // KEBUTUHAN visible password
  bool showPassword = false;

  void togglePasswordVisibility() {
    showPassword = !showPassword;
    update();
  }

  // KEBUTUHAN LOGIN USER
  var formKey = GlobalKey<FormState>();
  var controllerEmail = TextEditingController();
  var controllerPassword = TextEditingController();

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      try {
        final response = await http.post(
          Uri.parse(AppRoutes.login),
          body: {
            'email': controllerEmail.text,
            'password': controllerPassword.text,
          },
        );

        print('Login Request:');
        print('URL: ${AppRoutes.login}');
        print('Body: ${{
          'email': controllerEmail.text,
          'password': controllerPassword.text,
        }}');
        print('Response Code: ${response.statusCode}');
        print('Response Body: ${response.body}');

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          String token = responseData['token'];

          await SharedPrefsHelper.saveToken(token);

          Get.snackbar(
            'Success',
            'YEAYY, Login successfuly! 🤩',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );

          Get.off(() => MenusView());
          print('Login Successful');
        } else {
          final responseData = jsonDecode(response.body);
          String errorMessage =
              responseData['message'] ?? 'Login failed, please try again.';

          Get.snackbar(
            'Error',
            '$errorMessage 🤯',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );

          print('Login Failed: $errorMessage');
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'An error occurred: $e 🤯',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        print('An unexpected error occurred: $e');
      } finally {
        controllerEmail.clear();
        controllerPassword.clear();
      }
    }
  }

  // LAST
}
