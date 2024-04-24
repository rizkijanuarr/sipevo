import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sipevo/app_routes.dart';
import 'package:sipevo/core.dart';
import '../view/register_view.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  RegisterView? view;

  var controllerName = TextEditingController();
  var controllerNohp = TextEditingController();
  var controllerEmail = TextEditingController();
  var controllerPass = TextEditingController();
  var controllerAddress = TextEditingController();

  var formKey = GlobalKey<FormState>();

  Future<void> registerUser() async {
    var url = Uri.parse(AppRoutes.register);
    var response = await http.post(url, body: {
      'name': controllerName.text,
      'nohp': controllerNohp.text,
      'email': controllerEmail.text,
      'pass': controllerPass.text,
      'address': controllerAddress.text,
    });

    print("Sending registration data to server...");

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(
          "Response from server: ${response.body}"); // Print the raw response from the server

      if (data['success']) {
        Get.snackbar(
          'Success',
          'Registration successful, Silahkan ke halaman Login..',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
        print("Registration successful");
        // // Delay navigation to allow snackbar to be shown
        // Future.delayed(const Duration(seconds: 5), () {
        //   // Navigate to LoginView
        //   Get.off(() => LoginView());
        // });
      } else {
        Get.snackbar(
          'Error',
          'Registration failed',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
        print("Registration failed with message: ${data['message']}");
      }
    } else {
      Get.snackbar(
        'Error',
        'Server error',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
      print("Server error with status code: ${response.statusCode}");
    }
    clearTextFields();
  }

  void clearTextFields() {
    controllerName.clear();
    controllerNohp.clear();
    controllerEmail.clear();
    controllerPass.clear();
    controllerAddress.clear();
  }
}
