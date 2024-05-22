import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../app_routes.dart';

class RegisterController extends GetxController {
  late TextEditingController noIndukController;
  late TextEditingController noHpController;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmationController;

  final formKey = GlobalKey<FormState>();
  List<String> roles = ['mahasiswa', 'dosen'];
  String? selectedRole;
  bool showPassword = false;

  @override
  void onInit() {
    super.onInit();
    noIndukController = TextEditingController();
    noHpController = TextEditingController();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmationController = TextEditingController();
  }

  void onRoleChanged(String? value) {
    selectedRole = value;
    update();
  }

  void togglePasswordVisibility() {
    showPassword = !showPassword;
    update();
  }

  void register() async {
    if (formKey.currentState!.validate()) {
      final data = {
        'no_induk': noIndukController.text,
        'no_hp': noHpController.text,
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'password_confirmation': passwordConfirmationController.text,
        'roles': selectedRole,
      };

      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      try {
        final response = await http.post(
          Uri.parse(AppRoutes.register),
          headers: headers,
          body: jsonEncode(data),
        );

        final responseData = jsonDecode(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          if (responseData['success']) {
            Get.snackbar(
              'Success',
              'YEAYY, Registration successfuly! 🤩',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white,
              duration: const Duration(seconds: 3),
            );
            clearFields();
          } else {
            Get.snackbar(
              'Error',
              responseData['message 🤯'] ?? 'Unknown error 🤯',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
              duration: const Duration(seconds: 3),
            );
          }
        } else {
          print('Error: ${response.statusCode}');
          print('Response Body: ${response.body}');

          Get.snackbar(
            'Error',
            'Failed to register 🤯',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
        }
      } catch (e) {
        print('Exception: $e');

        Get.snackbar(
          'Exception',
          'Exception: $e 🤯',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    }
  }

  void clearFields() {
    noIndukController.clear();
    noHpController.clear();
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    passwordConfirmationController.clear();
    selectedRole = null;
    update();
  }

  @override
  void onClose() {
    noIndukController.dispose();
    noHpController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.onClose();
  }
}
